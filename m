Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32924C02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 23:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3872A80214;
	Thu, 23 Jan 2025 00:27:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="itIIAKzV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5575680275; Thu, 23 Jan 2025 00:27:32 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9BC180137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 00:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCkW04FeyPxXBo/pO0a0mZdcdhKtek9PrHMLZys2A/+db7dXg8sysclLTpyQLg3eWE5nqHCnY6ySpl9phWshkq3+r68pn2KSAT7F4JjO5Q14GOQXEc8gp+o08oKYAFJAA1jLUpzie4N8D8Wk2i3w7RgdpJ/PKKoc16Jngw/+qUNAl0EP7Km4AUnciB8Y1ZfEHBCWZD1h/+psyvD9LjnC5R7+CXscn1YSXI1Ii4PuSs43MjVKze4ddG64DGDwRIpqTZx4UYfHwOzyIjH+nY9BrAfF3DMT8vfasH9avznxuejmpcUh8M2XybsVe5sfc0npRUJiEjexrTqMehAnN1li2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cy6Jrq1CzYpsNSM2mIva1iTUIUS0DR2up0dj7oJvxHo=;
 b=DdIcA2zNNAqqPmNmoNp4VT/q1SWfxMOaixwLsxhV4g/FAwb8El+IYAG0jOumlU3I6SgXgqas9le+vK3umjSScDMQwjCbTjMVXomsiDnf7wA+2P2Uuf9dDM5zSe3qDkGWapwjt8jNBR0Qs/8/JVTVqEfTSUItRQfW3Ir/nAl2Q7qmo9P7bMLUWwi5wiCGB87dLdc72OPnnhXgomAVJzV9wXiTFpa4KP573Ex3n1GmNV73g8z9KZnrlEn2iiTWk+bpauqBFYicwW5sRDqruhIzdrLXL9JWpEYg8y7dyckWm0rnGNRn/tv3MHGKDb6oudmHp7AsJiB1jIL6nniksY91mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cy6Jrq1CzYpsNSM2mIva1iTUIUS0DR2up0dj7oJvxHo=;
 b=itIIAKzVh1F0ZTkm6UUE+bARungi6RbgGXPSrGo/mqDAQQyL7O2Qo8JLmI4u1h++pMMKhXOiaI3GV0kszVjFeZsGFMErxfyxenQJU4x3dMmM+nI/Pq9pqCtoBbEClAe7d9/5fPlGHWGHylMJu7zIh5fCgaOEDlM4jqO8fwVJ0d4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by GV1PR10MB7572.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Wed, 22 Jan
 2025 23:27:26 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%7]) with mapi id 15.20.8377.004; Wed, 22 Jan 2025
 23:27:25 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: "Rosenschild, Klaus" <Klaus.Rosenschild@hilti.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: AW: secure boot, mkimage with external signing server
In-Reply-To: <VI1PR07MB997209D177C705DD5371F0D6F7E12@VI1PR07MB9972.eurprd07.prod.outlook.com>
 (Klaus Rosenschild's message of "Wed, 22 Jan 2025 21:13:56 +0000")
References: <VI1PR07MB9972394B8A364AC9A18495F6F7192@VI1PR07MB9972.eurprd07.prod.outlook.com>
 <VI1PR07MB9972E22550B1514AD604D399F7192@VI1PR07MB9972.eurprd07.prod.outlook.com>
 <VI1PR07MB9972D12CDEDF3ADFF7D81B2AF7E72@VI1PR07MB9972.eurprd07.prod.outlook.com>
 <878qr4wm5o.fsf@prevas.dk>
 <VI1PR07MB997209D177C705DD5371F0D6F7E12@VI1PR07MB9972.eurprd07.prod.outlook.com>
Date: Thu, 23 Jan 2025 00:27:23 +0100
Message-ID: <87v7u6v38k.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0074.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::28) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|GV1PR10MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a9f04c-f301-4033-07b6-08dd3b3c5470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZzxR7gzoUmGyxGSblNl/oHUaYfZo5D1INyMcrOxD5la92oGuYKiiM8LHMW1D?=
 =?us-ascii?Q?23jg7l4aJycL0QZ74iqFBdMEHgozaNoC0q5HTlflKq+LT3ajGHpxQlJD5Gk8?=
 =?us-ascii?Q?h/Ox4DNIwEZqu0rrJCM9CtDiikAyZwE2B3pAqLhiAlf8tNgNY69gVa8KCyw3?=
 =?us-ascii?Q?Xjyo9ntmsB3SowWUPh9WYUiUnA6BAYA9SElzZ+hJJGnzZV5wWS+CMUlwnT0A?=
 =?us-ascii?Q?8gcmd2wFAl+KW7s8hOGA3swI+6x3H7EhYd+wt0IeK5yD5mexfHpzcL6/+6aJ?=
 =?us-ascii?Q?QCalXQNBk2YJj0p8gVt2LUTN6gw5jc4c+eNc4UYSXM3nDddZ2OUvW+ASMcK3?=
 =?us-ascii?Q?Mk02wv44l71P4IsXnA8A1ChUFDtFvylqCmc8Ahz1bxVXSINRWG9peD+BlLHv?=
 =?us-ascii?Q?F8ehXxkn94Vah45v8UCPWgqqJrGH/yEGvNvU3x+JyVS/f/PV3BoqtAMSKQS1?=
 =?us-ascii?Q?vtsx8A1HVKGmz4XfHKQVaHi7D1JvU+DQ/3/9nPf8R/3UnqcS1/xrtDxh/Wks?=
 =?us-ascii?Q?tkpMRWYx/eWKfTBS6UU+DKbnzH2yONwuuHQsikXVsgOs41bPNKx2Z4BYykup?=
 =?us-ascii?Q?aV/azZszu3J5SG4MXpMR1mRihRunmznWyNJtvi0y5wIP/7aMxkYgUuTEI3Sf?=
 =?us-ascii?Q?BhJbk21Y/y1hxzxgpns10UHRSyftWRo8A8sEhkXl6lZL8g2t/PZhIQ1C031f?=
 =?us-ascii?Q?1c6eXF/DnNhHuvV5JlM3lkOO3Q+ajnwRrf1JRbWWEPC9iFxK2JqsEpvBB+8M?=
 =?us-ascii?Q?0L8y8rq4ZoBi4t2S/GTmGrPQKu4bh5UMc57Ztvhai10IWc0lbvupgVsRJe+B?=
 =?us-ascii?Q?jwQKsOxzhEECehzeRkLfP0vEWYFM2aQWrEdIb5gBixEAkq5dBjnyHnz15hpL?=
 =?us-ascii?Q?0tE5pTb6UElZI/E+a1ryZRtYiV2+3RnnTfm2/zvwcqSrTBHbzIsYX5cYBowm?=
 =?us-ascii?Q?ihPkZJSaNBwaw37ZNUDb2RDzb2HjzNusuyOGVHAAR4jtommo4W9K8f0ObQTy?=
 =?us-ascii?Q?AAJq9fq8kbRDKmkonypSHNKEYQejG7bMhNRASKKvShVdGz07gt4YqjKQDQBn?=
 =?us-ascii?Q?XSB7p5eh8Bkg4/dKnQUd81gC4Q+7DwfeEUAsFVoFQHtOUUDgkvSVtoMGfyaF?=
 =?us-ascii?Q?zO2h6HP7VPZTbtXryu5TEQ9/beTt+DhIhkQqF7fVO90a5LPyPUq3BiQyuSHA?=
 =?us-ascii?Q?VOkYk7VOHFL/CfmyU8STXH0DdXSbA8zhQWtsm2XeuHQ3Zc2CN14LqGb+4byZ?=
 =?us-ascii?Q?3NA0Lwvn/ILPOdZRBnJUU4o/cRGcW12nQt+zgjVsDqU0j6E1TrQnNa+j6WES?=
 =?us-ascii?Q?loEYYtXUT/DQ3DDMY4UVUNGTjULdeYDO9019yVISM2F5thb9fM76wqShreUF?=
 =?us-ascii?Q?WZQ6mXWO8/A6VTNjXBZD2a9+R87WpC/tYKqKwVqDvdaa76epMHTwMQzwny6M?=
 =?us-ascii?Q?LgLYFRWl0VcjfwDyKh+L9C22gok85zhU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lBEz7paz9JpUNhIM2O+5QGflCUDsjOKxEBo7INQ6PiJlbmva8ryXHvxy20ls?=
 =?us-ascii?Q?oZdouoMqzSksbwa4XnUscQQqjSYKzjhHjXwmfC7e6IX7/UKlzifL4Cge8hSN?=
 =?us-ascii?Q?9uCebNiRGoREROvTZIbm9P/0tCh6zFdA8litorBLPl8RqbwtrhGIQkFqVDaq?=
 =?us-ascii?Q?28xmON0wKfvC2iIGbfVW0h6+nwjUwwXSuIcZN4hel2/kb45oCGD7GjMTBp6u?=
 =?us-ascii?Q?SrnJur8HX/FFXUA3rU953yLk9HGcwLKCLJbMVYd7vSAU//h72FFQL6knTqZO?=
 =?us-ascii?Q?BVk9TSc6bVa4SCalgtH7mbx5i2XVXjHUEAQMavzeyHEIQ2Rvwpicm5p8a1/g?=
 =?us-ascii?Q?4+WQSF/N4R6UzVBvoVntmRvx19d2/nhkpuKD/9Vzfbo2ArAbVp+k5/5tf9GL?=
 =?us-ascii?Q?dZR84TAuF2RFXWliHQI3bDSYvzY8GzIw4/EoUrG1s9NVfQDg5Q/3VjfzVaQA?=
 =?us-ascii?Q?1rvxED36Oo9k6fuAA2AKj4gn18+pdOttxA4il2M41l7c1tDX9m1EeFafaPrF?=
 =?us-ascii?Q?bdKAYtv67IZ/HsVT1YpXYwmYON2lHr9ukM2Tln8vYT1opaBvXm9PRdoYgOYz?=
 =?us-ascii?Q?y3GfG6CyTBKu2r32gADjzNZTUF4R7gKVPoCb5LDuOJB1JvBBj6lEn/2lgVgy?=
 =?us-ascii?Q?B/gTN0I/tsEHEs8oe+6Jwg7pXhySfmiujlYk2fIEzO1pS08Cp9D0Pc2Rr+Jc?=
 =?us-ascii?Q?FDPcJG0w7WaksF+EzFxprwXOsDwr2c1nJC+YYEBoyt6+UvhajHYR+225pJN2?=
 =?us-ascii?Q?T7tEjlBbQJOdSV4dOeOIkYiXQxu0Q+jymmV6JT8ECgsh1cS0ALrkggvOamYz?=
 =?us-ascii?Q?wSoiVVpvuuQJjpwchcoLnwpG9N1HZVWu4qsYbg2MB7izVAwW2Y3wgAiuwOh5?=
 =?us-ascii?Q?A4B3dZoUmLWbxjdUsogiFtF8o5v7AUK/rXwPwVyEciMwCDP0c7pn0eBuTln3?=
 =?us-ascii?Q?KUpdabKfl5BDPTMoRf+tGTCqd1Mxpzfzyz6ehwy+2R+XaqehWKQcsFAuOAXS?=
 =?us-ascii?Q?p1Fpzdk/iOyJKGkhTeZYjuuFx6keksDoOTstm47rdSlHyZ/vQF59KkfntdzK?=
 =?us-ascii?Q?5X9ShyEVbJ+RWSJ4BxuocD5ApAAORjpjwAhZOQ5JM40WuvrwhvwJAspicBMi?=
 =?us-ascii?Q?Zz7Z21PTJohriRm2De0kZYY44XkongcvvXp2xQZKnaXuJKAZW8V5Evdh7UWH?=
 =?us-ascii?Q?nCZsSVbH65WffC8MmvGt5L/pY8tlCx++WO/TpZRhbv0AVB/Gx3ueI2KkBMfh?=
 =?us-ascii?Q?PGsEbq8fqt1MfbqMX9cwQKRBunLArWnGsQW/sqvwiEWQJUQSeqxNHNlvrAkk?=
 =?us-ascii?Q?786WK0XH1wErinsCRELfNoVUEMhs+7CKvKX/Aug6XW3vtDG8HZp/dXbi320K?=
 =?us-ascii?Q?i+JTBE+m3GnZuKrn7F1daolPLbRqjdy/PlgruD921TOltFPzGE5difwbDw4h?=
 =?us-ascii?Q?Fr4Occd/ONU2sO4qynnLV5rg8XKrkdEV4z6k4nGm2igqHhQSvw8cJHywaf6i?=
 =?us-ascii?Q?pRz4pQyIyv8OoOhSqJdpRDTy97NfyiQ4S6M07OKrbR5++inHH5nJS6pNq+1n?=
 =?us-ascii?Q?P4y30GgcvvVpWI+ixsoFdfjNrHI5UuMTruI/z2zzOZ8yDXMeFQ5oNLFLzk+d?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a9f04c-f301-4033-07b6-08dd3b3c5470
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 23:27:25.8495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5u7rT9zRuEPux8tPWjboZZRgS+EHk5HmsKwUPWdpxdSMv2WJA31mq+JkmcZdKRp5qECHmQeyG/Bl0aJXwHYQlwUfvUTjgwd40XrCQNiauxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7572
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

On Wed, Jan 22 2025, "Rosenschild, Klaus" <Klaus.Rosenschild@hilti.com> wrote:

> Hi Rasmus,
> thank you for pointing to this solution.
> I think this is the best way to do this.
>
> However, our signing server is very well protected and making changes there is a long and complex process.
> Right now, it only provides the following two functions:
>
>   1.
> generation of a signature of a sha256 hash using the private key
>   2.
> providing the public key, the pure key, not the certificate
>
> I found a workaround to determine the hash that mkimage uses to create the signature of the configuration without re-implementing the internal algorithm that mkimage uses:
>
>   1.
> create a temporary rsa private and public key
>   2.
> run mkimage to create a FIT image with signature: mkimage -k keys-f fitImage-sign-orig.its -r fitImage-sign
>   3.
> extract the signature from the FIT image
>   4.
> re-generate the hash from the signature and the public key: openssl pkeyutl -verifyrecover -in signFile.hash.sign.bin -pubin -inkey ../keys/build.pub -asn1parse
>   5.
> now, I can send the hash to the signing server, get the correct signature back and re-enter it into the FIT image (e.g. via python libfdt)
>

Urgh, it shouldn't be that complicated, and I would consider it quite
reasonable if mkimage could be instructed to emit the hash it actually
signs along with the signature.

But, I do think you should be able to create a pkcs#11 module which
simply takes that sha256 as input from the higher layers and does
whatever it needs to do to talk to the server, getting the signature
back.

> However, there is now another problem. I also need to put the public key into the device tree file. So, I have to run a slightly different mkimage command (with  -K option):
> mkimage -k keys -f fitImage-sign-orig.its -r -K bcm2711-rpi-4-b.dtb fitImage-sign
>
> However, the -K options requires a certificate and not just the
> public.

Yeah, that is a fundamental design flaw of mkimage; one shouldn't need
to sign any image in order to get the public key data embedded in
u-boot's control dtb.

Fortunately, you can ignore what most tutorials tell you about that -K
option. There is a simple script in the u-boot repo, tools/key2dtsi.py,
which you can apply to just the public key, and you get a .dtsi fragment
that you can include when you build u-boot's control dtb. Either you can
use the CONFIG_DEVICE_TREE_INCLUDES mechanism for making sure that .dtsi
gets picked up during build, or you can simply copy-paste the contents
into your board's .dts file.

Rasmus
