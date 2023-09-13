Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F6EEE020A
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 19:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F07FB86A6D;
	Wed, 13 Sep 2023 21:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="faVjaWkX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94FD586BAE; Wed, 13 Sep 2023 16:20:54 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86344866D4
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 16:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrejs.cainikovs@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1694614851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nDd8b1f2w4ct8AKBeeoKvHm1gijaLcws5QZUSbDh/ts=;
 b=faVjaWkX16dHpx3mL3ZXqbiBs2Oc3or1Po6Z1hrEiwIKAPmAlBUwfTVppK51SyJZOJpOn7
 Sd1H6ZDx3+Q5g+xyltEGR1pO9FYdYx1QqXC/CAs1YjF+kLQCE/+Hv0RZe6Y1nMa9kjgSut
 fhgXGf8Nv6VS0ntz/4gElkoE1QgyeDc=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2045.outbound.protection.outlook.com [104.47.22.45]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-yNfKDj9NMZ6fxqMRrgrzZw-1; Wed, 13 Sep 2023 16:20:50 +0200
X-MC-Unique: yNfKDj9NMZ6fxqMRrgrzZw-1
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1e::13)
 by ZR0P278MB0742.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 14:20:48 +0000
Received: from ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::590b:1510:7512:c135]) by ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 ([fe80::590b:1510:7512:c135%6]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 14:20:48 +0000
Message-ID: <c566568b-bc60-f5f1-bdb9-8ef34473e962@toradex.com>
Date: Wed, 13 Sep 2023 16:20:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1] CI: allow jobs to be run in merge requests
To: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
References: <20230912110022.28420-1-andrejs.cainikovs@toradex.com>
 <20230913132125.GJ305624@bill-the-cat>
From: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
In-Reply-To: <20230913132125.GJ305624@bill-the-cat>
X-ClientProxiedBy: ZR2P278CA0050.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::10) To ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0254:EE_|ZR0P278MB0742:EE_
X-MS-Office365-Filtering-Correlation-Id: 491685f3-ada8-42d5-51d2-08dbb464a081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: CekqsXWSO504s3UEIihrB4+P5Jh6/yp+fAN4tEjdChrpGAhGdkIHQiEn14xIjA2rcFzX5yXFCXoPEDMnNKfFBCjEn3BYEYnSL+zPjaLwnfL+tXuBkSvVEzbEtOtVSi8znSQAQMNruLdl0m1yyKYdZAihMwrQrvlzV1afqWo0OZQG2+aZJkHTO90+qULEBoKTFoEKRZS0XIU9RAEqC+VO9Zb07svvgtQHyqKLMS5rkSigRAyPtluJiZmPiwd4oOdF6BhQPwPJxem6BEmNBxvKRPJ3GPhLMoIAicMHhOtwh0/vaqmhPoRVFUnQM4H89CBZ0njHO9s8Gi9gwHfygG8Z2yyPCj9V1fV8QE+XBv43ln6d0vakPv33KORZtHYb4jRyNvJgmcNSJ4822iXMg1iOSNfcZY4w4naCmvvGgHZDLWX/mNU9ybujwgGEHLMCUNdDPRnWiyYmelvlVNqDs63z6jNWSpypcrxq8jjSqujuBqngREALZ7TN4M6BPXT7uE7F/pDHxQrUp9yqXEFF8mUoGDIWNEEGErP5iQZoGZ/pMwCY6K0bnsEK+NwQ13BkiXgMhKHD7M65r8gs0fH0esQThqVZL8y/UwjW5Bbzo08ANbmFQiFD+NQtRXYA/nssxA9EM0Zg4BqlfYV/o4lGcnF2Tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(136003)(346002)(396003)(376002)(366004)(186009)(451199024)(1800799009)(478600001)(31686004)(6486002)(6512007)(6506007)(53546011)(38100700002)(86362001)(31696002)(26005)(2616005)(558084003)(66556008)(36756003)(4326008)(8676002)(5660300002)(8936002)(44832011)(966005)(66476007)(41300700001)(316002)(2906002)(110136005)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWkxdHVPUTA4TEtWaWdkWWxuQ1k0WVNzUkpEQnV4NFdHYUl1empseno2a084?=
 =?utf-8?B?OW9CSjNIUDV3T3h3YTBLbTlVTTkrTEd6aDVUU1FUVlVqalRUUVA1Y0h3K0RM?=
 =?utf-8?B?blFjNy9JRDc1WklFR0ZyTXJWSDlPSnNrdERFdnpHOHp0K3d0eTdPTjZhZFVC?=
 =?utf-8?B?bElLOHFkYXVuT1pFTDdSTm9OVk1lUml6d0x3azZMd21oQTQ3dGRJOGRsWlJV?=
 =?utf-8?B?N2tjK2pER3RqWGNsbG9CcjhQMWlWVGhheVkwbEF2a1hQYTdrc0FYbDdXQ20r?=
 =?utf-8?B?RVVjSmE0T0puOWRtM01tbDh5c0kxdy9YYkpIcHZ3UWxBVUdITXFxR3J3ME9T?=
 =?utf-8?B?allwdkVDTi9KemFNeTFjeHdwQmlsQXdFOGFqUUpSTXlLa0EzdE5NUmlnL2Iy?=
 =?utf-8?B?R2hPcVU4MkRpOEhkOVd3R1pCcU44OFVydDBNeExGWDZUTzhsK3BmdStmSC9t?=
 =?utf-8?B?L0JnNklBaWVaa0dpcDdmU3RmUXo3TGszL3paenh4ZXBHVGF4alFhd1NmemNr?=
 =?utf-8?B?c09zMDRNZFZhSUppZHg3L0hJQ1J0WUhRZlFmT2NkQm1aZDV5UVU3bE14bDVo?=
 =?utf-8?B?WDh6ZlVva0VTOHorN1pGM1N4RzNlaGZqOUhaUnJQL3RsN1FPeGlFdkY5NjJL?=
 =?utf-8?B?Y0tLWHRzSHNvdjUvdS96SkdBa2xKZXZDSkJyNWJ4VUNkbllWejZXZFBvSFl5?=
 =?utf-8?B?NGtjTG14SVlPZXNaSENyejh1TnVQbG5iVjNpc0tITDB5NzFqeHkwOFBFMWlJ?=
 =?utf-8?B?V0hBZTRGR1g2SERUV25JUzYyVnFrRnRuM3pQbVVBSXlRNy9qT1dqS0FMWURP?=
 =?utf-8?B?M0piSGR1czFUdWtJaVBhcGtDNWxjY1pMTzYyVXoyc2FvaVBwV2JST0Z6Yi82?=
 =?utf-8?B?Tm84SkZaUytzNmRIeXhVODlYcWdrUWZ5OEwvSGcxanBsR0h3WDUzK2RnQzI4?=
 =?utf-8?B?VGtOY2ovTWhONmFjZ0tZNklwc1doRnNVQzl5SW5kUU5QTnhFV3RjTVJUcnJT?=
 =?utf-8?B?U1pJT2EvanF5a3dVTmE1R0VZckdXdzQ4bS83Tyt5a25xMEZXOWJlVzNQYjZv?=
 =?utf-8?B?enVBNm0rWWFoWlV1RXdaN1EzbkNELzJDcHA5R2ZIOUxaSCtQM2tQK29mR0R2?=
 =?utf-8?B?ZjAxMnJqRXRXMnVJbTB1M2Nzb3dlNWw1RTk3b0ZFa20wV0Z6c29sa096M05o?=
 =?utf-8?B?YWJ2Mlg2QTJvdTZVSXpidVBhbGRBQ3NKa1gwUDZvZFJEclYyVzh6SWlQYXFu?=
 =?utf-8?B?TWJvZDh4ZDIvOHBuODJ5d3Y3eE4wV3JzaTI2RGNDaFpLTWlVRDdoWkdUejJB?=
 =?utf-8?B?ZE02b3NrNFFVcDR0WS84eTBqZ3Ruai9CQkRoREhlWW50d2dDSURRam9CZkdp?=
 =?utf-8?B?Q01EUVNaM2ZwT011SUIxTi94NWVDcU42NjJzWFU5a0VGa3VLaUY4TmdSV2FX?=
 =?utf-8?B?eDBqeWF3TVJZWHRqb1Bsc0JURjk4cHR2N2RFb1BhNWlpcU4vYnRUSFRkNVNB?=
 =?utf-8?B?OGI0MTI5TWM4S1hGUVNEMVZGS09FaS9kMTdRSFF5eTRPYzA1WU5zTTk0cXEr?=
 =?utf-8?B?NmVIZkwyak5lelh1Q0pob0RTTE12dmFkK1lpbzRUQU9xekcvZ3gxUmgwS2N2?=
 =?utf-8?B?N3VnR2NjUUlTUGFXNk5XM25MRFlRSVpxTFlOVy9GM1NSVVhqYWtSb3BoRlJT?=
 =?utf-8?B?eFcwTmN2VGhNWE1NQmI0eXB1d2puQmRFQmdhWHRlWjk1WUsvQVRqZ0FUNDk1?=
 =?utf-8?B?MG11djVnMDZUakFWWkJxUEhGYStpR2ZPWHZyYjNyNThOUG9LS3BDaWNqS3Zq?=
 =?utf-8?B?a1FFcCtNN0FEdDBObFFHdlQwYWFHR1pudUozMGpmREtnaVRxbXNTWHpSMTZ0?=
 =?utf-8?B?R1ZHSkdmNGZZQkR4WVkxRXZ4RXlwajVFUVVFZFd1SHp5ZzIvenlPSWtXMmdJ?=
 =?utf-8?B?R0IxUkQxVVRVL29YcUM2RDV4S200akxHYnB4SFVETjNodHBNVUpZNXB5ZGUz?=
 =?utf-8?B?UTdiSTA4MGxET3cxdm84MmlFQzBDSjQ2b2VoZm1LTjZSNkovaVk3VlloTXNI?=
 =?utf-8?B?dFRiVU8wUVZka0hDVytPekJLOVV6c205SlcxKzRNVFNaMk1lQzVJRHczZ0o1?=
 =?utf-8?B?UU4zNW5abkwwM2Ixb1UxbkRCVVFMUk5IeTN2ZmtidTZ1eWFxR3BTdFNvcm9t?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491685f3-ada8-42d5-51d2-08dbb464a081
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0254.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 14:20:48.6968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhpbx7c6o1To8RHVThPUcuGySW2OyjytS+5vRwACigaJHtRLcon+B+fpsq7zZMj2gIgbJocYqbGb0gVQdGTqE5MVgr3N+aZH1+44krQdD+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0742
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 13 Sep 2023 21:37:45 +0200
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

On 13/09/2023 15:21, Tom Rini wrote:
>=20
> This seems fine but please rebase on top of current -next, thanks.
>=20

Thanks for your quick review. Done in V2:
https://lore.kernel.org/all/20230913141536.109844-1-andrejs.cainikovs@gmail=
.com/

--=20
Best regards,
Andrejs Cainikovs

