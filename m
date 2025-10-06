Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346C4CAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 14:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1DFA83A3D;
	Mon,  6 Oct 2025 16:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IW/gmZFe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D80D83A45; Mon,  6 Oct 2025 16:07:46 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13B7883A35
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 16:07:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScfJ/39t2uWJk/MHPwl2IfVvvC79rMr+7XZdb6UJEVpYTNc9INIHQkaj/416Dv5kNlZrszYmWLuwmZ/EdAzNbTK4SiitB0ciW4OcRf76yEqnCuexHqJdgodn2WnP//hTS6eRLbdN1M2LOKKBrTrwbTHea1RQRLwn1TJikcfC9hXPoTZNMqDACKj7ZCuIu64b5bQPIQyIOTKJzdEGmsgb/6C+iklD4xhlc5WkY34byPLW7q2vNbRrNMiFEyEJo1snRP5VlL7BlgEYhxOWOQrBKPkaXL66uI47oPwGq4Bv61mbzdUZrslH6nUbk2QBBaUBa0ACBN1czv/qy2DBmxn3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsCmNa9D+Dai1UXdbIJMBNCddm4U3imeXAOgIhdnd9E=;
 b=hpk7iXWEoeXWbHt9PKpZotw8+con9Cv3Wf9rpPQzQUL4wNZsDSznU72L2ZP+01XDPNlaARXm07XbJWMdsjWTYO9foufTuWcND8Cny4fCyeAiERAV2OgWWLGHgNPxUFFMjtyJiuTfU0Hs0G07KkZTxr7apP1KQaeeitgJNkE+DtpoqFaBdeT7bYThiUvVt8AY/dFDULd6BEsgvOLF0U1PDguELI1xsaTzWgtie3IpUogymmQvlv74EoEypGH5ycvCZ4bLhGaHbIwSxNiAZVc7aSvWKG3S7ZA1/Fy6K+o5iKfKOA3HqwTkF62bLcGsOMi1wxqx7V1SeMIc69HSykAxmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VsCmNa9D+Dai1UXdbIJMBNCddm4U3imeXAOgIhdnd9E=;
 b=IW/gmZFeHwa/r58revo5vxD7xCOdPkJCg+ZlO3rYSfqnabopeUcL6JUgaZELyjTcxhmcFmgL1Zph0I+38kSFkCppsAgLrr1m5oHDsBnBh0/t0NCw5JrgkQu09WQPhlr9dwYbMyAm6oOgyM0HTAhCvyMMpbu0x2xaHHdYCTUtgN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB11615.eurprd04.prod.outlook.com (2603:10a6:800:2fa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 14:07:40 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 14:07:40 +0000
Message-ID: <9cd3aac2-a337-48d0-bc9b-2f27957fc582@cherry.de>
Date: Mon, 6 Oct 2025 16:07:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: jffs2: Remove always true test
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Petr Borsodi <petr.borsodi@i.cz>
References: <20251002-fs_jffs2-v1-1-d53365c53f8c@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251002-fs_jffs2-v1-1-d53365c53f8c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB11615:EE_
X-MS-Office365-Filtering-Correlation-Id: fd03c150-b7ef-43e9-43f7-08de04e1b60d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekVLUEJadU8va2Y5MERzemFTQVUvdmlRM2VHeXpNNGdUb1RxRUdyamF6dlF0?=
 =?utf-8?B?d2hyWDVCYXVQa1ZOcEpVbnN5MnlTVFZQRml3c25IYU8yK0ZvekN3R0dnZUdF?=
 =?utf-8?B?M1NFTmFHSG5QV1JEZ2FwNTBXejJtN1lrT0UrVE5IZGNZNW5lRDJIU0ZoK2JR?=
 =?utf-8?B?U1EzTUxFcWFhZ0g2TWVTRjlKdkZKeDlNVFdielhZb0dBU2g1NHVLblMwVVNG?=
 =?utf-8?B?eXdHSWxyRTd0VzdLOWFWRVNxTHExSm1kaXU2NjNmSkRKT0pZR0wwRUhvOXVi?=
 =?utf-8?B?a1ptTG1LN29iMkY0aDZhZnB2SXp1LzNNZkRZV21IUHRhL0lneUI0Smh2bVVh?=
 =?utf-8?B?OUF6eUpFRG5WN2NYOHdSMUQ3SkUvWFBuYllWVFhaSXFUa2Z0YzBCU2ZaVDVO?=
 =?utf-8?B?dHo0Ry9EdnBpQllhVG5ManhBcEtJS01qOUcvYXZpTndWaDEyK3hkR3dsWis3?=
 =?utf-8?B?UzRCWEQwU3JRRHFVa1RlL0ZyTllRYWJteVNnZTNGaWsrWlNucG5PaFlnc3Fo?=
 =?utf-8?B?Q0RFczBEYW9JQU4xcDhrdURJTzVzdmVFRnZzNVV5alJhcUY4NWpUNk95aDlu?=
 =?utf-8?B?dUQ3UzR4NHFBNzcxaWttQXlmY04rWmlTRkN5enNkcy9ob25tYjlPSDk3SnN4?=
 =?utf-8?B?MGFDRXlmNEhLOFVsL2g4WmJ4dy9oaURoTDhPV1h6eXdybFBzcVNVV3ZqWjN2?=
 =?utf-8?B?bGNLQVBsMnVpcnBOd2hUakJYQ3hSaGlicnpMN3ZFU3JCWlZzRFppOXVqMjdD?=
 =?utf-8?B?eW50ZUJQb3F4dUhRMXA2Y3VqclJCOVllTkFodFZ6cVhiQjZPK2x2MTJHcXpk?=
 =?utf-8?B?dE5sYU9GZ3k4NlJIdVZhK3FUNzc0MFN0VHlqdjQ4THZNenA2aGg1S1JRQ29G?=
 =?utf-8?B?aGplY2czMDlCU1g3UTU3WHZNUDB2ZGkyT25sMXQrakNEWm85eWJPanJTWXFM?=
 =?utf-8?B?eUhoV2VxR3U3bGNIcHNVQnptSElTMm9EVmZ4cWRld294aTNmNjR1SGhVYlpy?=
 =?utf-8?B?MUZIbWpWaFBHNVdlN2tuQk5OSU0rbGZHRXpvUkNnOWhlbFdyalJGamFMUnlI?=
 =?utf-8?B?OFQyMjRzYVU3eW9rNWNTTnlpMUlhVVZacUxKTDlpZm9aaDk3cmx1NTZjZVND?=
 =?utf-8?B?ZExuOGl3OHV6LysrVk5NQzgrOUF1ODhXNFpVSWtGQk9NVWJSMDBrZDZLZG44?=
 =?utf-8?B?SURFTGtVMU5iRVlDc01sZzVjSmdUbWdhSnoyakdZRkJsYnZKS3htbkRTYUM2?=
 =?utf-8?B?Vk1tdDROeUxqbDRPZGlyTFlhR2VreXduMEdTcGhleXQrL0tnT0NHcE9xVmN0?=
 =?utf-8?B?NVFzbjR4SVZ1VUlFaURVUlR0K3N6a3F2UWZxOVhEUXFyaWtRSGZSL3R5ZVFP?=
 =?utf-8?B?cFJCR0dsR2huVWJacHpySWZEVU5STTk5WTNVcWtTcDJQTkNGcS9TeDNRZExp?=
 =?utf-8?B?UFVIOEdlSGkvNkdGMTlnY01jZERWMTRBQlNNNjJad1EzOGQ4VnBOU21nS1ZK?=
 =?utf-8?B?Vmt0Z3YyK01GUW54VGlENzg2eTQ3N1pJNXAxdEtqVkhCSEZFYlJBbzBJcW8y?=
 =?utf-8?B?UEtqYmJ3M1dYTGtwN0ZPVWg2SmI4YzFHWjVkRXpDTEdqVUVwaEI1U2JPaUtw?=
 =?utf-8?B?VW00ZVk4RzgwSlQ0OHRqSkpsYWVaeFVwVXlvWTJVTytwOVFodWlJRFBnNXFj?=
 =?utf-8?B?anFvczVCZ09vbUxKSXlvZHU0VU51MmE2SUpJbmdzM2RyRUpJZEdjSUJ4Uy9J?=
 =?utf-8?B?dFUyVWdaK040TktkUm9rS1dKa3JvNDYxU0xDK05IMUxwZHBJL3lQTUFPbzcy?=
 =?utf-8?B?eEc1Qm1zVSt2ellUK0NmSy9lYjdTc0w0UUdvUlVkNjFaR2w2RVoxNjc4cmNu?=
 =?utf-8?B?L1d1ZHRsOTlGZGIzTEpYZ2prdlk0WkxoNUxuSkovcm5tT1hla0swTzJJY0ph?=
 =?utf-8?Q?jV2trB71zqzASTyNXsnuWLp7o4/UFeqD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzlGRTJrdm9ZMjJHY3dhMU1HcVVHT01xd2c5anhBNXd6b0RhT05DeW9qZmpv?=
 =?utf-8?B?Uko4MTJsOVp1RWEzb3RnZjVqaUdIKzRleHRaN2luN3hDNmJaek9PUVc0YU5n?=
 =?utf-8?B?TDZmQVNwODA0akRuS2lUWjIvbS9aNmYxQllOdTBIbWhtVzRPR2ErN1k4SkRL?=
 =?utf-8?B?TEwwOEF4dmNKVi95WEVhZmxNZ3JMZkF0VHczYjVPSm5wVE1ONXA1eXVnNVdu?=
 =?utf-8?B?WFNjR3RzcHk0SnRpZldpcFc1aHRleXZseW53cElUS204MDlMYm9HQlBRUG02?=
 =?utf-8?B?QnByMThVQ2sycUJzL1NsQVN1L0VZcXRjRUMwOEFrNkhSYzJPVzlTcVNDNXRo?=
 =?utf-8?B?Z3dmcm5teDhuMXQveWlTbGJzQVUrSks1emlFaWhxSFpWandLZ3VjRkRxNlk0?=
 =?utf-8?B?UzB1RmhWZG9wQnFJa3ZSZkQyY0hSQ1R0b0dWK09VcUwzQVdTcW8rZzlCckxo?=
 =?utf-8?B?N2FuQ0RleENmbUZUZXg3NndPOUFOSlA4SmRwTHo1WkgrcnU0cThpN3ErTktZ?=
 =?utf-8?B?cEpoN3JoMmpIeU5ER0lGcG9tR2tzaHVnbzFPa2RwNkp1THFGSGlvbG5yUzQ0?=
 =?utf-8?B?UmpwV3d6Rnk2VVNVMDdsQU12Nnp6UnBxV1F0RUpMc3R4ZC9xSzM3bE1STHA5?=
 =?utf-8?B?TVQ0YlV2Rk0xUU5icHV3bk1GSllvdmh3ZjVqYm9WdTg2M09udWlGWmlKbk5C?=
 =?utf-8?B?TmVEcy9TbnVhYThDam84cEZEbldocnk0RXIyaG1LSHkya1JBRUlkZkZYN1Bx?=
 =?utf-8?B?Y1dzWGllWFBRUnVOL3pkN21mZmwwbm5WU3B0TzdUQTlRdUxsQ2k5S3NCM003?=
 =?utf-8?B?LzdIUXhVUERRSjBJZWlpL0IwUmI5OGlDYzdnZDN6Y2VzSjYvUUZkdk00RHQz?=
 =?utf-8?B?OWRkaVhIQ1l4VTU1MHdRV2QvbHZtQlR1ZVMzZW5nZCtsdWxGVmNPSFBOdFpF?=
 =?utf-8?B?VHBDcnNJNnRoZ3lFb2x3cHd6V2xJVTdMSmtPRU1YdU1xWGZBd212RTJyd3Fl?=
 =?utf-8?B?TGM0WW9SV3RaNk1NZXRxeWw2RGVjbTlDN3dKblhiUUVmWUdkSnNqNmVUNWtu?=
 =?utf-8?B?ZStBKzNZREV2Y3JMYkFwNEJ1cTBnZk1yL2hRZG5XT3F4enMySURUYVhWZEF5?=
 =?utf-8?B?N1l2Wk05aUZYSWdRdk9xdlNRS0k5SFNBdlZuS0ZZVzZmd2wrdUZvaFM5Um9T?=
 =?utf-8?B?bVYwVlpsL0RFS3ArSWt3WmFrMW5MSE5KdXpueVhUeEhCTGpVeEtiMWtncnk4?=
 =?utf-8?B?QnFKQ0R2a0wyQ2lUa2NneGRocjNOemEwVjBuajloeXkyY0p2aitSQ2IvY0NB?=
 =?utf-8?B?OS8yb203SGt1dmhRb0ZZMFc0aEUrOGN4REs1SStYbEx1cHlHQ0RvWmFRRFM4?=
 =?utf-8?B?R0R5S0VOcXN5Z0NDVnMra2haWkhFK0x4ZzY1OTVzZG42YW9ZcG0zdUZEZVY4?=
 =?utf-8?B?Z1FXUnpBM1dCK2IxcDRwbEZvWEZ3OTYvQUNoTk94cGd0TmxwUWNIWFc0SDlY?=
 =?utf-8?B?RXdsSWdQSzUxTHpQQTVUUVZ2bmYrRDJEa001ak8ra29KbWZhbis3SnY3dVVk?=
 =?utf-8?B?QXM4VEdtWGUwMy9VK3BYZVBEbmVCSXUvMjJGUHhOczRnZXdVNEd1NGxqN3Fs?=
 =?utf-8?B?a2FiQUpKd0dEMlkwWXpEZW90NHlzK3dJd1JqMmppRUx3dmRTeGcvSDRhVmVz?=
 =?utf-8?B?NWVmYmVNSis0WEovQXQrNFNoNUxjbmZJTmVZWElWU3JPV0lONUh4RnFuNjRp?=
 =?utf-8?B?NVE3L3pTbEVpNjhtcFRkbGljLzNGL0Npd1YrbzEvSXJjUG5CM3grc1lpL0l4?=
 =?utf-8?B?ZVJVKzd6Rk95cEhXdzZjYUttd09OTDBzYS9yd3hLYmhKbVdueDZUZGk3cWNx?=
 =?utf-8?B?My9FN2NZL0VRL1FBS241dmYyemdEZXNoajd6QWwzUWNPVTcwem9TOWhZODVD?=
 =?utf-8?B?VXdPODArQ3UyT1dBRlJNSE1KTGt4dmd0ZTBZYnErYk0zWk42SFF2V3VMNzZT?=
 =?utf-8?B?K0ZPUXpzSmpKVWpveGZxbzVxMFNTelRyYVplenpUZzZOY1ZuQkdBQTF0djFJ?=
 =?utf-8?B?NDhwaVBZOStkVmdRd0ROKzk3dDVQK2lvSVNJU1NobzhETXEvclcwQnZMRUJ1?=
 =?utf-8?B?QmtJMGJ0aFBUa0pvKzR1SEoyR1RHOE0zR3J3Nm1BVlI1SEZrNkpMdkV2elVt?=
 =?utf-8?B?NkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fd03c150-b7ef-43e9-43f7-08de04e1b60d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 14:07:40.3280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTlbn8Tk/6ZNIaEwBT++APqivkev80GoP+GTXmLW83LCdYyGoj16ElJtYdr6zjQkc50OT+ns9aW/rUUKzkEJlBDJe8SqCmPpEZ69OSc1AsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11615
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

Hi Andrew,

On 10/2/25 11:29 AM, Andrew Goodbody wrote:
> Testing an unsigned variable to be >= 0 will always be true so remove
> this redundant test.
> 

I checked if it wouldn't rather be an issue of the wrong type being 
used, but i_version is:
- initialized to 0,
- set to b2->version with b2 being pL->frag list element which defines 
version as a u32 as well. The version member is set from jffs2 raw inode 
u32 version member, so we're good as well on this side.

Thus,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
