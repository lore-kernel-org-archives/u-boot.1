Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9FCC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 11:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2350287623;
	Mon,  4 Dec 2023 12:23:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="YHbaI6Y7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23F0D8775C; Mon,  4 Dec 2023 12:23:19 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EBD687716
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 12:23:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAUHngHzn6Tnr7bjv738g/5FGp/IEIAX+IbLfZzyNmT3afAqIVcLsCyrkamzDQ0pueDSOG16HdpQu6K0d7Iu9wfK072ftEKwNs+BjldmcR78llmGoqvddzB0mW/FRD+nN3ug9yneh1+I8Atp2WSxzIu9/0K7XWL0KBFFAtB1bCEG2txEQrmKiB7jQz80JLFNC2N2/3RkFbaomO0ozAK6WDozY1yhuMS+qvrPSDM8KwdTDSo36pBUsMU+QCiEIqu7dRwRW1tXo7Z7mvdXgjztw6LMCGkOBF67S2viUqx8Zt+qON3vUQDClYk/i1kbVLjUD+FjXpCvG/d2d+32EkJ23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgSVVGQ89GXSO4jojJOvg+jk2MVWFWQaojFIWUNkiPU=;
 b=AkWtP2LgaoB5LTMqYaHs+T32mxHHTb+DSp64Re+kld4BkSjsA8WLWydiPb1JKgfuDO3nDNbNrOD4BEZH2YaqdY71brhtEnaTGBZd9zEyqYUGXHQPEzmzprAcpDvXutwPtl1d7pSTZ/K5JE6s3QHkSi9N12lJ6p+ffbehdz/ABifdh0F5Tu0iOvh86lJpIR+pUwcuFfR7b+g/JI5Pa/+cSKdzMNb9bZPzsSqNlUKqGWOWdeikCpbHTRR4QVDmOwgVA9AWgbRplvZGv+CgKLAUk7pkl7tUV5MS9HP0nNzAASIpcGeiqLi7agTjYZiDlWUpdt2iaJEeoCeYphPle/50NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgSVVGQ89GXSO4jojJOvg+jk2MVWFWQaojFIWUNkiPU=;
 b=YHbaI6Y7UnhAe6UhI7ng92s6DyS0UAAapq0HE5j0MHGInPOqwinJXpIcO1lhA4V74omTB1J4bzgcE+E+a38PaVpi94JDcTMgOeo5+qwsP8yWdfxR3KA8oWqfEB4aHO5AjirpmkuBOZp6Qsfv0HjzAI3jlCMO8g8L3VgkO83QRh3BVj/Kmz1zMBNedYm+BJxH8i4qh4udk2HvgzoEhplcUuQPEetCw1Cf74m40WlQkvTbftno/ISNqxTtSV47a6o17XjCkkE/w/lUNWvBBS5I8Ue7zLQBxp9fSr6S3GLrF8AwpaOqivB6zPb7qUGyox9sWkSWstldZyuKyVHxJklA7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM9PR04MB8308.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.23; Mon, 4 Dec
 2023 11:23:14 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ee0:71d6:cd29:289a]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9ee0:71d6:cd29:289a%7]) with mapi id 15.20.7068.022; Mon, 4 Dec 2023
 11:23:14 +0000
Message-ID: <144a797a-fc0b-473a-9d6b-7c62f5129036@theobroma-systems.com>
Date: Mon, 4 Dec 2023 12:23:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [u-boot-gitdm PATCH 2/2] Add some more employers
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20231203044719.667116-1-sjg@chromium.org>
 <20231203044719.667116-2-sjg@chromium.org>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20231203044719.667116-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM9PR04MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: d17482b4-6957-4a6b-9c8e-08dbf4bb67d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lOY6kWu6uTN4rmONZOzBEc1oL1FmZvaH3VSUi16Aq48Z+aS+WxA5UUHKAuMBWeuewd07iSmKsZfNNieO1TOUxkAO7wzSivYta99LFYKjHM0z58J0JEfccX53CLg7UNwda9CjC8r5jJy4zwRdCpSGiX+NiqaCu89kinbEC7k/BCPITXZaOdqUXrur4mmRdQ3yVbNV5PCy85N0J0QDInzhcbXGXx51JJ7foRaDoHDdwvMXBh4YfWrhX/h0LiCXCm24d+ibuqmG0XjpyfqB1XQzqTvw31wZGXucW+lMsx60vxqiF2h58jNE177Aaa76Ch3Fy/clLn0OT+rphMPgcjzTLNAnOIp5QBVF4g64SVNsD9glnko8ZtK7oQdVuhDSgDZEHbcG6Gwt49l0gaAxRybXmKgHjv24HHzcEmCzqOKblJ6k39HpI6FdPWGzKQrIwfHJXf2H6rNwVn900TNU6W4DuMUn1xPy3tNRmngVJzcztv4T25zsufDWD7TJj9v/KnfhcH2tZ683k3h4NYPKJvcNqM+zcucZp5lORMxQR7bZxC08VbHfSnZzGQPJ1iL6VouOA+DxK0dHyr1XjbNuRXk75MpXdI7rJaWyEwbpeHmK+6X1Llyk39ZWbYMDmAcKLTmNJ2XIBbyOeSnEL5ECt5Brmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(346002)(376002)(39850400004)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(45080400002)(6486002)(36756003)(6512007)(53546011)(6506007)(26005)(2616005)(41300700001)(38100700002)(66574015)(86362001)(31696002)(83380400001)(478600001)(2906002)(316002)(66946007)(44832011)(110136005)(66476007)(66556008)(8676002)(4326008)(8936002)(31686004)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUd4d0VzQkhVTzdqeUluWm9RbUZDWk90UktGREVnTGxDUmlwbmd4VVVpVW9F?=
 =?utf-8?B?NzN3U09aaUR0eFEvOWF2YlBpeEtrbEoxczNUNWJJYlRuQnN0Znk5SEtTYXNN?=
 =?utf-8?B?K2pEOGxNQnpYRFV2amdqSnpZTjc0TzU4dzQ1N2hiVjNYaGMvQ3BTaGNWZmR5?=
 =?utf-8?B?TXJBQVJYWnhOKy9OR25mVGdDN1daSG44UW5nL3d0cEZFalFDN2l4MXNHbkNM?=
 =?utf-8?B?ajN2Zk9jSy9nRnlEdCsrTGQ5UCs1NFMwdnZJdWdROGlIK3JFSUhQeU9DU1VG?=
 =?utf-8?B?bndLdHkxQ2xhei8razRTSzZ4SklZUlcza1kxV294ekZTdDRpRUZYbzBKLzY3?=
 =?utf-8?B?d0dvM2dOTTJKd3NyY2huOGRsN3cvRXNjRUgyZEY3OUZIOXpqZUlTVEVXa0Fr?=
 =?utf-8?B?R1hjMjJPZWpLWTdUeHVVdStac3pVUVNROEtrK29HNTkyaXVQZUlyeFIwUUEw?=
 =?utf-8?B?L0VJbm5PVTV1MUVHb0ViNlpGaGJYTUtjT1pSSHlCMWRFNStucVM5Q0hGMDhT?=
 =?utf-8?B?RmlLdnVyRVdrWjhwM0laYW1CeUx3QW1pZUJIMFV2VUdNakpZQXNYUE0wcnBj?=
 =?utf-8?B?L0N3d3RlRXZuS3IrL1h6TFRTZTNkUXBKdXE2S211Z0ZpTDhmYi9oNmFjTnVW?=
 =?utf-8?B?NkVpYlRIWGNBUDYwRnBybkp6T1p6elo2YkMrZno4MDUvYTd3S2IrcklveVRa?=
 =?utf-8?B?azhKbHNHREl2UU9td1d2VTE0T1FOa2NiS3hWSGVXcnBEcklWekRwU2VVWVc0?=
 =?utf-8?B?d1FDYWlIdjBYL3FmaDc2aHIwbzZJcDFpZXdSMGYwU0RRckRQMzNLMC9kNnNi?=
 =?utf-8?B?Y2JmQ3pRekFrckhFWFAzN3FsNUJjWFNhMk90MEIyQmJ3VzQzRFU2MVVsdFRp?=
 =?utf-8?B?ZXVCVldFeEdwUVliZXZ3MGRGK2hjWUdwbHIrWFN0Zm9TUHhIZ1lCSjRzOU9s?=
 =?utf-8?B?TW1VRU5tZ1pSMjlGUXNEMTBlejVtSDZ1cXFjanoxT3grUzNBRWFNY2FpaDBq?=
 =?utf-8?B?QkQwU3haV3RNUEZzM28zeGhBbi9vd0dWT3gxNHJNSWhGd0RTNGNKM2VhdWtr?=
 =?utf-8?B?eGVQa3RVNUludVZnRmk0dHAwQmFCN0VvVE9DQTBFcmEwY0xhaE9ZV0FnUkE3?=
 =?utf-8?B?YitUMFVSb2dNdGhpbDllcmVYWWNYeUx3VlZ2eENERzNSaWhtS0VyMi92YU5E?=
 =?utf-8?B?WHMyMnpuc3ZGSCtMdnpYOGhTNlg4MTh6TmZONHhTbk0yLzMvbFlrMGNFS21i?=
 =?utf-8?B?S3NHeGtibEl1bjZQTmxSTGRkRnJQcTBlOVFpLzdFWWdBZ2syaXNjL1RDSm5B?=
 =?utf-8?B?ZGY2eWttN05lYTVrUmFZR0t2VVhuM2xtMHV0OWdiNnVvL3FQUURzYXllT3lh?=
 =?utf-8?B?MHBUR1l6NkFVdXUrcHNoZ1ZQa0hEeHBoRDFENXZQcUFaa0hWTzNQYlRQRndD?=
 =?utf-8?B?RnlCajUvaE56SVMxUEx4WmtoWTFkVExDOHBnWGNNSStnb1lSQlI1bVRQU0J1?=
 =?utf-8?B?eFdpdDdYbWl4VnRyd0Vxak9OOHZsMnY2NDJkMDBmaHJnVU9jRW9sc2tvY3R4?=
 =?utf-8?B?SDNjQTE5bDNndzIvRWdvS0FwZXJUVnpJOEJMUzMvOE83dERjU2Y0dW5GUWg2?=
 =?utf-8?B?NVM2NFk5S1lqTUNxU2UycG4rTkhyNzRYdWpJZ2JOeitSYUdENVZITWtZNS9I?=
 =?utf-8?B?MTZVNmJ4QUZRYlFMMnJUUDJsL1ptMVEzb0wvNmN3ZnJ2UFpRamRvU1FlR2F1?=
 =?utf-8?B?K0ZHTHhqd2NBOXA1SDdOaEsyS2k3dThwR1hwblNjR0s4V1NTdzduT2tIYllE?=
 =?utf-8?B?em8zeWVKdUJVVkJGRW9Fb0dSemszOWdjUHRtL0Y1Z1ZiQmIyUTcxN0FING1I?=
 =?utf-8?B?NTU2YW5rdy8yVjQxd3FEQ1pEZzQ4YlprOVlKVTgrYzdjZkdJMk9PSko3MnlS?=
 =?utf-8?B?aWNkOWpsTnN1aDNyRE8rV1VtOXorMVJRQUFDR295MlJudnVlK1FMTERNUzJl?=
 =?utf-8?B?STRVbE1zTHdGUFJBcXVRcDg1MHZSMW4zVTlad2lpNGE5SEVhVG1JZldnZjd3?=
 =?utf-8?B?bFZUVFdRVERERDZ5UDliV0FhSGozQllZU3RFYVlHbEY2V3d0bkJFQ084dFNU?=
 =?utf-8?B?OXdJTDFvQTdYdFdmTXJVemxmQWxKUlF5T2d0UnFnYlhoWFBKS0hsQkxsdnY0?=
 =?utf-8?Q?xfLKn+4+soRb2O54kJP2d+U=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17482b4-6957-4a6b-9c8e-08dbf4bb67d6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 11:23:14.2544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyXg0HfNRzxfqxv/XcAIkfZe1plm6EfnGvLyqXbYP3IFCDt5bq21BG2mb7pQjNYvLTdxmly31O6StF7A3eE1JGszsnDp41uimQtBGFwzqaVkHrfD6OOE1SntQuyuJxLq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8308
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Simon,

On 12/3/23 05:46, Simon Glass wrote:
> This looks at the top unknowns:
> 
>     git log --pretty=%ae v2023.01.. |sed 's/.*@//' |sort |uniq -c |
>        sort -nr |
>     (while read count email; do
>         if ! grep -q $email u-boot-config/domain-map; then
>            echo "$count $email";
>         fi; done )
> 
> It reduces the (Unknown) count from a third to a fifth.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   u-boot-config/domain-map | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/u-boot-config/domain-map b/u-boot-config/domain-map
> index 63cb60f..27f1a7e 100644
> --- a/u-boot-config/domain-map
> +++ b/u-boot-config/domain-map
> @@ -18,6 +18,7 @@ amd.com			AMD
>   anagramm.de		Anagramm GmbH
>   analog.com		Analog Devices
>   android.com		Google LLC
> +andestech.com		Andes Technology
>   arastra.com		Arastra Inc
>   areca.com.tw		Areca
>   argos-messtechnik.de	Argos Meßtechnik GmbH
> @@ -44,6 +45,7 @@ bluewatersys.com	Bluewater Systems
>   boeing.com		Boeing
>   bootlin.com		Bootlin
>   boundarydevices.com	Boundary Devices
> +bp.renesas.com		Renesas Electronics Corporation
>   broadcom.com		Broadcom
>   brontes3d.com		Brontes Technologies
>   bt.com			BT Group
> @@ -51,6 +53,7 @@ bull.net		Bull SAS
>   bus-elektronik.de	BuS Elektronik
>   calxeda.com		Calxeda
>   cam.ac.uk		University of Cambridge
> +canonical.com		Canonical Ltd.
>   ccur.com		Concurrent Computer Corporation
>   cdi.cz			CDI.CZ
>   celestrius.com		Celestrius
> @@ -58,6 +61,7 @@ celunite.com		Azingo
>   centtech.com		Centaur Technology
>   cesa.opbu.xerox.com	Xerox
>   chelsio.com		Chelsio
> +chromium.org		Google LLC
>   cideas.com		Custom IDEAS
>   cisco.com		Cisco
>   citi.umich.edu		Univ. of Michigan CITI
> @@ -78,6 +82,7 @@ cosmosbay.com		Cosmosbay Vectis
>   cozybit.com		cozybit
>   cray.com		Cray
>   cse-semaphore.com	CSE Semaphore, Inc.
> +csgroup.eu		CS Group
>   csr.com			CSR
>   cyberguard.com		Secure Computing
>   cybernetics.com		Cybernetics
> @@ -89,11 +94,13 @@ dell.com		Dell
>   denx.de			DENX Software Engineering
>   devicescape.com		Devicescape
>   digi.com		Digi International
> +dimonoff.com		Dimonoff inc.
>   doredevelopment.dk	Dore Development
>   dti2.net		DTI2 - Desarrollo de la tecnologia de las comunicaciones
>   e-coninfotech.com	e-con Infotech
>   ecitele.com		ECI Telecom
>   edesix.com		Edesix Ltd
> +edgeble.ai		Edgeble AI
>   einstruction.com	eInstruction
>   eke.fi			EKE-Electronics
>   elandigitalsystems.com	Elan Digital Systems
> @@ -119,10 +126,13 @@ feig.de			Feig Electronic
>   fixstars.com		Fixstars Technologies
>   free-electrons.com	Bootlin
>   freescale.com		NXP
> +foss.st.com		ST Microelectronics
> +foundries.io		Foundries.io
>   fujitsu.com		Fujitsu
>   gaisler.com		Gaisler Research
>   ganssloser.com		Ingenieurbuero Ganssloser
>   garzik.org		Red Hat
> +gateworks.com		Gateworks Corporation
>   gdsys.cc		Guntermann & Drunck
>   gdsys.de		Guntermann & Drunck
>   ge.com			General Electric
> @@ -140,6 +150,7 @@ hevs.ch			HES-SO Valais Wallis
>   highpoint-tech.com	HighPoint Technologies
>   hitachi.co.jp		Hitachi
>   hitachi.com		Hitachi
> +hitachienergy.com	Hitachi
>   hitachisoft.jp		Hitachi
>   hp.com			HP
>   huawei.com		Huawei Technologies
> @@ -164,10 +175,13 @@ jmicron.com		jmicron.com
>   jp.fujitsu.com		Fujitsu
>   juniper.net		Juniper Networks
>   katalix.com		Katalix Systems
> +kernel-space.org	kernelspace
>   keymile.com		Keymile
>   keyspan.com		InnoSys
> +kwiboo.se		Kwiboo
>   kiethp.com		Intel
>   konsulko.com		Konsulko Group
> +kontron.de		Kontron
>   labxtechnologies.com	Lab X Technologies
>   laptop.org		OLPC
>   laurelnetworks.com	ECI Telecom
> @@ -176,9 +190,11 @@ linaro.org		Linaro
>   linutronix.de		linutronix
>   linux-foundation.org	Linux Foundation
>   linuxant.com		Linuxant
> +linux.microsoft.com	Microsoft Corporation
>   linx.net		London Internet Exchange
>   lippert-at.de		LiPPERT Embedded Computers GmbH
>   lippertembedded.de	LiPPERT Embedded Computers GmbH
> +lionizers.com		Lionizers
>   llnl.gov		Lawrence Livermore National Laboratory
>   lnxi.com		Linux Networx
>   logitech.com		Logitech
> @@ -194,10 +210,14 @@ mandriva.com.br		Mandriva
>   marvell.com		Marvell
>   matrix-vision.de	Matrix Vision
>   mediamatech.com		Mediama Technologies
> +mediatek.com		MediaTek Inc.
>   mellanox.co.il		Mellanox
>   melware.de		Cytronics & Melware
> +metanate.com		Metanate Ltd.
>   mev.co.uk		MEV Limited
> +microchip.com		Microchip Technology Inc.
>   microgate.com		MicroGate Systems
> +microsoft.com		Microsoft Corporation
>   mimc.co.uk		Mercury IMC Ltd.
>   mips.com		MIPS
>   miraclelinux.com	Miracle Linux
> @@ -269,6 +289,7 @@ phytec.de		Phytec
>   pikatech.com		PIKA Technologies
>   pikron.com		PiKRON s.r.o
>   pmc-sierra.com		PMC-Sierra
> +prevas.dk		Prevas
>   prodrive.nl		Prodrive
>   profusion.mobi		ProFUSION
>   promise.com		Promise Technology
> @@ -278,6 +299,7 @@ psyent.com		Psyent
>   pwav.com		Powerwave Technologies
>   qlogic.com		QLogic
>   qumranet.com		Qumranet
> +radxa.com		Radxa
>   rdc.com.tw		RDC Semiconductor
>   realtek.com.tw		Realtek
>   reccoware.de		Reccoware Systems
> @@ -299,7 +321,9 @@ samsung.com		Samsung
>   sanpeople.com		SANPeople
>   sanyo.co.in		Sanyo LSI Technology India
>   savantav.com		Savant Systems
> +sberdevices.ru		Sber Devices
>   scram.de		scram! e.V.
> +seco.com		SECO S.p.A.
>   secretlab.ca		Secretlab
>   securecomputing.com	Secure Computing
>   semihalf.com		Semihalf Embedded Systems
> @@ -323,6 +347,7 @@ southpole.se		South Pole AB
>   spidernet.net		SpiderNet Services
>   st.com			ST Microelectronics
>   starentnetworks.com	Starent Networks
> +starfivetech.com	Shanghai Saifang Technology Co., Ltd.
>   steeleye.com		SteelEye
>   stericsson.com		ST-Ericsson
>   stlinux.com		ST Microelectronics
> @@ -343,10 +368,13 @@ telargo.com		Telargo
>   teleca.com		Teleca
>   tensilica.com		Tensilica
>   terascala.com		Terascala
> +theobroma-systems.com	Theobroma Systems Design und

Better not stripped :)

"""
Theobroma Systems Design und Consulting GmbH
"""

Cheers,
Quentin
