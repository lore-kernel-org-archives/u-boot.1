Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2C1D116F1
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 04:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B234284171;
	Fri,  5 Dec 2025 05:24:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DEnkYxhS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E62D284171; Fri,  5 Dec 2025 04:12:58 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33B21840FB
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 04:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=qijian.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irtRnyVRGI+GUaAZyOHBRhljODvqqtB86KuCid403sFOdkjvkbDFpKJ704XMZRL8uA1/uO2rCsGIVN8iAAcOMAutd0hFhhcPm2/FdyV9zppcUsNaSBqT0G24INeUU7qxWjcHhTmqjsYuRlrGrguLM5cKpHDEr0EmKFsJkkd4Mof2QnOhnmGz2lmr9XEJ8QKcTbb1K3P7NFCHeskYu3s+IXV08L45cXN1csl1oRUMkTrAYMeVhms9pFc9rfyWOTKpetcrZq4kZkCCzc6R62GzYcaaMqMSV8108egyq6VQSPz6TLv5/C3WG6QXGHgr3U04pPDHRICVgL5WzV1LBwC8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykoht+i381SdWzkaFRN52PNqepj6bp+uN3a+D7qYsnY=;
 b=uS2f+iY3JsjmPA/WIgG/BuKx0GDnZRbHWkWVr6nOe05I61Hm9aPEdd7S6K5yNg0uR4lBgvtD0vIGTgJiFMdU8QcGZ9Afe24THg/DpK59AN52tOZzDvFatRf+OhiYOfYHH6AZnLMHG8XAVOrq5ZBhZpSIBfxGvnruuo4JxVWHLU3s11yeYcVzCa0O7C2Xc7CzKSmKUNSbSPHoL4PWS19WyqSM/TME2CNFGaKw9VW7coGqDK/WHKqmKiWyHNlkUDc05DqRnVS+OBxFM9TbFC7fAK7aCultnLfEb2NU16cqbqpiyxVQU0J0aXcFFMJIf+9eL3FFK7WqF5yB8KFI4JqFwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykoht+i381SdWzkaFRN52PNqepj6bp+uN3a+D7qYsnY=;
 b=DEnkYxhSZW/nQX8WD8AuipZN9ZVJVCVofHyvK2CEvpiANMVKMGLdr20VT8x4ssEgIFBlZr5XLfXKM1HEa996Gu3pTZGG3HzJbesBAwncBeQj8Q6YzI9poudoLElhUJ676rY0j2f/Uzw1r3i6/00iQxeZbWurdZ56gYuXageahG+SEVbzWErcDU2kc+/Q0/6Jx6IusglSfHci5fNPYXXfZ3y01cttZm+KImikh5gppwIVbA7BoRAWRrYPaDrsuJHNYfUNTd2z/LIWyP9XI7LBj8vvM4s+t1tor90wF3t41ybyygvm1yEW/Wmgf/nb9ChxGyuh3XYZPVuWbzb8sbtOUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB12135.eurprd04.prod.outlook.com
 (2603:10a6:800:324::21) by GV2PR04MB11446.eurprd04.prod.outlook.com
 (2603:10a6:150:2b2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 03:12:45 +0000
Received: from VI0PR04MB12135.eurprd04.prod.outlook.com
 ([fe80::9d6b:8a99:daf3:45b7]) by VI0PR04MB12135.eurprd04.prod.outlook.com
 ([fe80::9d6b:8a99:daf3:45b7%5]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 03:12:44 +0000
Message-ID: <8eb15a35-bc1c-46b8-8f49-a2f37d2638d6@oss.nxp.com>
Date: Fri, 5 Dec 2025 11:12:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v2 2/2] imx: Support i.MX91 11x11 FRDM board
To: Fabio Estevam <festevam@gmail.com>, haibo.chen@nxp.com
Cc: Joseph Guo <qijian.guo@nxp.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Adam Ford <aford173@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Mathieu Dubois-Briand
 <mathieu.dubois-briand@bootlin.com>, Francesco Valla <francesco@valla.it>,
 Jacky Bai <ping.bai@nxp.com>, Justin Jiang <justin.jiang@nxp.com>
References: <20251202-imx91_frdm-v2-0-992b8aa99375@nxp.com>
 <20251202-imx91_frdm-v2-2-992b8aa99375@nxp.com>
 <CAOMZO5Bu6735Rb=CfwBMeiJdStqx6ATZVQU9=-EngzkK2qhVng@mail.gmail.com>
 <93024512-1ab0-4fdd-aed0-f52849528c21@oss.nxp.com>
 <CAOMZO5B+NtDy1WOgOF71F2OzrpNzbDeUctvOKk5eK55H9Z4f6g@mail.gmail.com>
Content-Language: en-US
From: "Joseph Guo (OSS)" <qijian.guo@oss.nxp.com>
In-Reply-To: <CAOMZO5B+NtDy1WOgOF71F2OzrpNzbDeUctvOKk5eK55H9Z4f6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To VI0PR04MB12135.eurprd04.prod.outlook.com (2603:10a6:800:324::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12135:EE_|GV2PR04MB11446:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fae1075-b782-490d-1fd7-08de33ac28bd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|19092799006|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHZSQk1iN3I0eE9WRUY4ay9OZUR0S21SYzg2MXliL0VrK2c2NkY2MzdPT2xz?=
 =?utf-8?B?UGNmeWdHMng5ZU1BbUwrdUg4MkJvZm5XQWxTUk1OaU1vRnhkWkxpalZpbVRS?=
 =?utf-8?B?K05heGlVY2cxN2RNaWNLWWIxL0RPMmlIdlhwOXJXeGhJdVhqS1IzN0xZS0pW?=
 =?utf-8?B?TDdET0RmRXJQYS8yS2dCQy94MVBjeXdFU1FBRFpnQlJIOENRWldvVklNUFVH?=
 =?utf-8?B?Nk83OEw5Q0FCT0ovOE5nbW53ZXpNWVhNbEx3dU95QWNNYjZrQVY0cUFXQkI2?=
 =?utf-8?B?alNVdGJQU21SaGxaTVMvSk9NZU00Q1QySGpQcXVheW5TUWVJVmpPSW1PNGx3?=
 =?utf-8?B?cUV5ZDNMajB6VjNsOCtDRThmUXloZTVxN1RZVWhKQlRuWndxVVZZVTVLUUV1?=
 =?utf-8?B?R0lJOHk5QU1uSFcxRDZVYkNkNTVvZ0VKYnBTKzBhZDRCR2RheUcxTVpMZFJR?=
 =?utf-8?B?UUl5NTlCYkhDeGxBZU9uSG5BQjFlam51UjIwMG5XQVVYcHg3bUhBUXNZUFpz?=
 =?utf-8?B?bCsveklYOHdSSmxBUEllZlJLVlVjdXRxNUFpVUNXMWVpa0thU3BETld0MERo?=
 =?utf-8?B?MEl5QjcwYUN4REN2L2NjanJqaWdRdHJ6OCtUNDlmNVd6NDZwbjM1Y2VmN0V5?=
 =?utf-8?B?Zi9mSE1NdEhNK2NEOWhzYW5HL0FWLy9RRXBlVk9tcWl2dG03RTlsNUhob2lB?=
 =?utf-8?B?elUybDNSSzVCQTA5dE94TVJqUWpleWYrdStnMkxITzZ3aGRqVWw2eG5FaVlD?=
 =?utf-8?B?bmgyZGhtS3o4ekc0SUh1c0dxRWhQMmY1eldpN1hHQyt0cmFJMGVBRWVCWk5E?=
 =?utf-8?B?MzR2Y1VydUlKRXo0N3MvbnFBcitveUpzTWtraERMNDZlT2s3SGl3ZlJRQXNH?=
 =?utf-8?B?dXVlbHg5SjBNb2srYlNBNnpQbnA5eXZ6Wm1US2pkTWlpUDEzQzVSNVVKUlNU?=
 =?utf-8?B?ajd5VWNTQ0kzYm8wMTRZdlZnZXI1UVZLNW9qWTRQSW95eXZkNUo5OEJFRW9o?=
 =?utf-8?B?bXlzUGMwaHFlZG1lWk42aWZTVE1ObzFKL2JuV011dFJoU05NVER3cFdoNHdo?=
 =?utf-8?B?V0ZZbVpncXZJQWlsWlcwRWpZbkxMZTU5MWJ5VDFKeTZiY1YzcGY3WHVyemZv?=
 =?utf-8?B?dWZLUlJ1ZjRucDREczZ3L0VYZ3BlM2VPZmR0a2NCMTdRZTk1SWFoWUJYbTV1?=
 =?utf-8?B?bDRIZ2FyeDRzVXJvNE9vcHlpV0lVSFhEYldOVzhCNWtVTWpSYmhuL3ZIdkZY?=
 =?utf-8?B?VjA3WVFra3J6WFJ3aWorRVorTTdYVVlveklhMk9ic3NISEU0NGVZQjhTUUEw?=
 =?utf-8?B?bWxrWHJ1N2pJNE9ZeVEwQ20zRzNvTUUwSEJMTjc2R25oMXRGWWFiMjd4eUk2?=
 =?utf-8?B?SlExUk1KbkVzdXhGZjFvQzhEdlZzblVGTmhCTjVxWU9aYytWWEpCMitycnVh?=
 =?utf-8?B?VGpRQXU0VmxIRjVCdVB5Mnd0OXpFQ3MrTGxselY2U0RsSHJZTU15SzFjZFFI?=
 =?utf-8?B?MisrMVNRTWVGSFM4b2FwbEh4ZnY2c0FJN0dCN2JvT0hrOTFVd0MrTmVmN1B1?=
 =?utf-8?B?UzV3RStPbGZUQ0ZuVEJTNGw0YWloVnAxMm5UWnRjM05oV2VHNXBmQ0E3MjEy?=
 =?utf-8?B?bGYrVWNaaVVKTWZTOFJEQ0EzRmk0ZlFUK1JLYkg4RExETkk3NTlvWUliVEJj?=
 =?utf-8?B?Q3g2TjNnYUdFSWozVWVkZ0pCVkdiL0NXUUREYlVEVzZ5RHB6NTZRN2VCSXRL?=
 =?utf-8?B?L2ZUTzhkYk5rS0E5TVBqSXRhUWhKcW5PVFpqbHFqb25vbVIvYVcrZ3l4T1lx?=
 =?utf-8?B?YmVuRnNyVWFnMU40Vi9RK1o5dEJFVU5QN3hMNmloQitmUy9yUE0rcE81QU11?=
 =?utf-8?B?TXlYNkVGR251bjhFRDViUCtyTGxBTzdQUjhjdDE5encxRXI1KzFLd3g0SWk0?=
 =?utf-8?Q?AAGPX0lBRbUcjOBlf5I0F3tgBl4EX+Fk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB12135.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(19092799006)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUpJeEtpNGYzeHdZczUrS1JFcnBqSkZoRWhZSFR4M1RTYnlDMHE2MXgxNndV?=
 =?utf-8?B?UXUrUzNNRStlQ1dnZXNRWlNFdGh1RERsNjIvNjVxNVVDUUNkV3JpSDBHb00v?=
 =?utf-8?B?cndRL0IwS01zMWJON3JRRGZqZ25zdkt0dnNBMnNhZXd3dUZMUk1adTdHYVE0?=
 =?utf-8?B?MEZrVkIwVjM3SnpYZ2RnQkJ3dnpBU3IyWVFvUDZaQ0k4Tk04RGhjVnpjUVIv?=
 =?utf-8?B?d2VVcHZmUTRDV3RWUEF2RHpFZmgzNExVbGxXV01aNmxVTUljYVdkb3R1THVm?=
 =?utf-8?B?MzIvWFU3RDJrbjBUTEtZZVA3cnhsRk9DNjhOeEFMaEo0NDg2VlVFNlREaFFF?=
 =?utf-8?B?bXA3OHpHRCtQRWxieXpHUXZiYU1JVDN5VklOOStuK0p0cG12ejVtZ2hIYXJH?=
 =?utf-8?B?MEdGZjdaWVRvcklCYmN6WmtEVEZUTmRYeTVJY0o1NWNIS1VtRkdEazdNT2RO?=
 =?utf-8?B?aG5KZTNOV0h4K3BLcGVqUVlxSmRKSnpRRE1qNC9tN2xwdmZUUXNDWWE3QjRM?=
 =?utf-8?B?MFFpblNGalF5T0dKdHRkUFNOVkZuMkhkaGdJclBZdGNoclByRUFPWTlabUNQ?=
 =?utf-8?B?Z3VrK3J4ZEpweURkNFpkQTNHVlZWejVxaGl1U29JT1VTZElZWEtaOEpHQUhO?=
 =?utf-8?B?VVB5NisvaUdodWRGNVd0OG94aGRJOUdKUWsrU1BWRlpKZm5OTVZ0ZERybk5x?=
 =?utf-8?B?eFlOV2p5Wks2NDJTRGRGNWJ4bGpBNE96U3ArNzJvcFZIWVZ0YnlQLzdJS204?=
 =?utf-8?B?aXZ6WDRvaDZxZzRQY0tBelJaOFJWMkFlQ1lXdU1mTmdHdmE5SUFpMUZBTU9W?=
 =?utf-8?B?Q3R3amZFenpwNWlmQWFWWUR2enZuT2trYVh2S3NUZTdqY2xvQ0JlbjJORVQx?=
 =?utf-8?B?Qk1wc3c5Ylkzb1NkTzNOU0dMTnRvaFVvbGZ0QmR1TFlwUW4vSitleUJjeHNU?=
 =?utf-8?B?QTBJbGFGUjVoU3EybjZhMlNOY29jQ29vQVpKbnpyclRoU1g2V0ZrMVkxbExM?=
 =?utf-8?B?UjU3ZW5BbWpLNVRRMnFWWUhxUlpkaFN2dEdXR2VNWnpxWjJVVjczWjNJL2ZY?=
 =?utf-8?B?d2pveDI0cXdUaHc0MVpsVjZpdkxsN0RaVXVrRmpzS0NLNTVSWFNvd1d4T2tI?=
 =?utf-8?B?VkpMN2VpK296V3ZiKysxRHcvYnRHMk1wSXExTDhwa2RLYkJTOFVqMzF5MS80?=
 =?utf-8?B?RG1RNzRkNEJ5Z0phT0VwalhBRUJUdkxxYWtqZHdiMkl3OXN0UjJkbWc3ZEJp?=
 =?utf-8?B?aFpJY2x0b0kxNkNxNXY1UWxJbTNHUmc4bCsrQ2paQkM0a3RmbEtBSmFlczYv?=
 =?utf-8?B?VUd5eEN5SGhqTUlURXRLWVhPS0V1OFhXRVdiSGNQemFmYW9vQmNrRmhpSm9J?=
 =?utf-8?B?REV4SlJNVks5SFBUeHJ3eWR5Wk5wSVNnWTJSNTZ1Qm5WcUN0cm5ZaGUvclZV?=
 =?utf-8?B?bWhMalRVSUdhbnY2SEI2aVBGYUp2RUpzMlF0YVF5bndhUUtGR2FESmprdVRX?=
 =?utf-8?B?TEZ1TCtYb2owcnNHZUNmQnlyWXVDU0x1NUllQWx1ZVR4SnVybXY0akZlRTRD?=
 =?utf-8?B?NmlpZmRlNUlEZXpHSVlOOGhaT08wZkxKQSs3SXJ4Nmg2ZlRiNStKcFpIMTIv?=
 =?utf-8?B?UEgvb2Q3bHk2UVJDRDlKbTl6SzZ0MENBTldBWHFrVlNtRTZvTHVRWjlBYmhs?=
 =?utf-8?B?Vk5XMFNZS0NWQ0lTekYzSFN6Sk15bFhKMWVoQndpQzlnbTl1RzIza3lyUEFY?=
 =?utf-8?B?aXBHaW9CVVFjZEpzQm5INWQ2SUxwVFNoL2p0eHBUTFNQemxmaVpIL1JJNS9h?=
 =?utf-8?B?YjNIN2ZFRXlONnlaWC9mOHQ2cWNEbVhyTEZkUDNROGQ2UVN3eVlmWk5waHQr?=
 =?utf-8?B?dG9pdm5uZUk1ZHNQTHFuS2ZLOWFBMXdvU3NSM09CdUQ5VXFNWXNiZGV4a0hU?=
 =?utf-8?B?d3NjVldHUGtVRWNNRXM2QTIxOUpDdFlQeEJPL0hWNERlT1lmSXNJblpHQjZh?=
 =?utf-8?B?OWw3emhzZUwrS3pUWjZxNTkvb2REcWR6Szh3b3RnYkZlR3E2S3hyTStlMStJ?=
 =?utf-8?B?REdqcEhTRE5jVlV3WXdlZ0EvMHIrcklBcDhiZ2RPKzgyMEFzT0Z1WFFLNnh0?=
 =?utf-8?Q?lGigkhUJ0P0kOG/g/1kaHOcJk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fae1075-b782-490d-1fd7-08de33ac28bd
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 03:12:44.7492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKhoxDkcTCQ8zt+eam3NPnAM9NG5oOd/AC2xJxUVfvMsks8LQ/ywJfVMaiZiWS/QRsxSQRV7N/9wmC/PCc2vOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11446
X-Mailman-Approved-At: Fri, 05 Dec 2025 05:23:59 +0100
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



On 12/4/2025 10:03 PM, Fabio Estevam wrote:
> Hi Joseph,
> 
> On Thu, Dec 4, 2025 at 4:12 AM Joseph Guo (OSS) <qijian.guo@oss.nxp.com> wrote:
> 
>> Hi Fabio,
>>
>> USDHC2 is for SD card and its initial stage is at u-boot.
>> The IO voltage switch from 3.3v to 1.8v need extra 8ms time on some
>> platform. I also tested without this delay, SD card can work as SD3.0 on
>> imx91 frdm platform.
>>
>> I prefer to remain this to avoid potential risk as 91evk 93evk 93frdm
>> all remain this property.
> 
> I understand that a few NXP boards use this
> fsl,signal-voltage-switch-extra-delay-ms property.
> 
> Linux does not use it. U-Boot should not use it either. Whatever
> solution the kernel applies to provide this delay, let's use it in
> U-Boot.
> 
> I would really appreciate it if you could investigate this with the
> NXP folks and try to remove this custom property from U-Boot.
> 
> Let's keep the U-Bot dts files as close as possible with Linux.
> 
> I appreciate your understanding and cooperation.
> 
> Thanks

Hi Fabio,

I understand your requirement. But as I said, the IO voltage switch only 
happen on u-boot stage, so it is kind of u-boot specific requirement.
So you mean we need to add this delay control into kernel driver, and 
add this property into kernel dts even kernel stage didn't need to 
control it?

Since we don't have this issue on FRDM-IMX91. How about I remove this 
property on this commit first. And we can have further discussion on how 
to resolve this property.

Regards,
Joseph
