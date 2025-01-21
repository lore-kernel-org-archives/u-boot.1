Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E2DC02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 09:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB652801F5;
	Tue, 21 Jan 2025 10:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="PPHkBTDE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 465C380326; Tue, 21 Jan 2025 10:29:03 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 282C0800CF
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 10:28:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLHxVt8XbwXSZKt+randjVaY5jJWtNwKHlYIiMNWI6R6VgaW4DDLvHk5nCNKXBhFIvNV0Ug1LDzEtWaiYxFdReJ8TAZ+mZYQD5QQOww5sAmr83LINsXQygeQwIHB0iqbbxnewordk6x6tpM/rEPpTOp53Me5RZRoaxbdmKqMT/8jj75AeW8Xsexpfs1wVm2/F5P5hd7Gmx+S5xYMBuBRwg2LVwQw7NY9gR9O1qlOkBZ98ENxJk5WBc2u9JXGmCJfBMqzkQ5Gt/mAzTYZUHJibfH/wEUkmNSXFrKMhqfC9VCY5johrebvMOfhOHvV50UqL2pBX9fk7C4d8BrWAMo/VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkEoWmri0F6eKGhMLM8U4xo1YAabXQ/fgkjUage0tSk=;
 b=XLbCXrdeqAuZx9QaNHwLRuGdhwcW1oU9qiT4YpLc/mDQSGZRqMqvJks3gD7x+HlC3FsnTbHH63+VgapwC9pANKStpu3TI+22ewHsoVaHsAUZkyI1JaaKXWf3XIcOMPdDDGFgLrSuBYsO/SY7dOwIoIprbOd4UdeKLkyTwahPuIJkpul3YkvK0cF15+QooYL7kj+EYjV8PGRhbAgKWNNBG7fGW9dCNgB18OflyzxQq7vXOSQQSnTx0Ro0yplYHbWbKuqorE5av9MUvq5eVrI1ka5Pz5wbnZe9whky+ftkM62zSUc9R1gQWEU+5gdwk9n1xVMW/ptHThMAsgi7uT4ybQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkEoWmri0F6eKGhMLM8U4xo1YAabXQ/fgkjUage0tSk=;
 b=PPHkBTDEISc506PrFjuRj2p8rZU2AIax0Sr6sr8pHVECLraSiNU/jpF1rffB4TBF0N8sw0/E4aA0+TEKVYR/XdYZKCHAg6Yw1l0s6zjGhNoaqTEF0KrD73zhINBMpM+8HXU3Af182mVrSs+AUUgtn5vYYDRyLvQU7SmM/7CeNRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by DBAPR10MB4091.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.13; Tue, 21 Jan
 2025 09:28:54 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%7]) with mapi id 15.20.8377.004; Tue, 21 Jan 2025
 09:28:53 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: "Rosenschild, Klaus" <Klaus.Rosenschild@hilti.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: secure boot, mkimage with external signing server
In-Reply-To: <VI1PR07MB9972D12CDEDF3ADFF7D81B2AF7E72@VI1PR07MB9972.eurprd07.prod.outlook.com>
 (Klaus Rosenschild's message of "Mon, 20 Jan 2025 17:43:19 +0000")
References: <VI1PR07MB9972394B8A364AC9A18495F6F7192@VI1PR07MB9972.eurprd07.prod.outlook.com>
 <VI1PR07MB9972E22550B1514AD604D399F7192@VI1PR07MB9972.eurprd07.prod.outlook.com>
 <VI1PR07MB9972D12CDEDF3ADFF7D81B2AF7E72@VI1PR07MB9972.eurprd07.prod.outlook.com>
Date: Tue, 21 Jan 2025 10:28:51 +0100
Message-ID: <878qr4wm5o.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0001.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::10) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|DBAPR10MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fe9a7e-4f01-43e5-0fc3-08dd39fe059d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n6kbQIhN6iJYcPHPttUM8TEXz7Km9NJkSOc0pQhVj7MKC91U10FuW9v60tTn?=
 =?us-ascii?Q?RDisEaUHscNhvrp8FDuHPa0nbJjmuHSx3YZqWkCSEHyUCeAYU52VZHgJVe33?=
 =?us-ascii?Q?aV4m7hV6vLne1+UnB6c7M/N9G82BpP0/bzRI5ZySVNjzhV76cthVgevpd6TY?=
 =?us-ascii?Q?0fqo73mqDqZWLf4bfUsrqLLJl9imZI4g+VZPWRLiPWpPVPR+6wP8HZ2sdB9e?=
 =?us-ascii?Q?t6tkn+O8+4wXfe1Vh77iQhh+U73QQrByRDUpouXLc96vqD/7pwO3UmsMJs0i?=
 =?us-ascii?Q?HanNURwcnjN/JnjUruEWFr6LrlYfkm3FBso2zN4AQO0M46V7NhheIVZuOv3p?=
 =?us-ascii?Q?jPm9RDAQ095EGOmhNRbpjw5FGMJOIDklbwe2i64JqWxjXIhUWux0RLNucoGn?=
 =?us-ascii?Q?y1mH09IgPB7S+WS7noqgcZUI3s9AUBDxsRqjHzj1csvk5s8Wq9YCunPa66eK?=
 =?us-ascii?Q?3KzROD/daQYKi2auFEFYUftb5qmrKZc0kaeWr78994J3j8pbayv02DAFpdsa?=
 =?us-ascii?Q?vwf3Whof7L7CFHSwo6EaiDf1HoqqLhMREOiwZeHhiMnkl2ajWnDa970qJ2at?=
 =?us-ascii?Q?Ux5q/SRFfclMt2f3SIP+SfvMgbEHe9JKK6jBEH3YHnELdE0lbrHTZxGTF1tM?=
 =?us-ascii?Q?KcR1bD0HzGjkuxlObJZeWOnkK1+AFkOTDKQs2ojgOsSzcsG0xb/avIb2DGXr?=
 =?us-ascii?Q?8bfBoY0W58cJP1aCitm/kGUlZSh7KcCki2217BVQkFBK97TpU01W3WUE20s0?=
 =?us-ascii?Q?/6PFy9aLmdmpmLDL/B5tN84+7Y0P9iKcqs90nwS8reVt9BmetUs4Lsw17Z77?=
 =?us-ascii?Q?5wqUkLzoalA+DgcWJIzO9DdJkY4Ivmq0g3dQnwlUVQ8Vx9VaI7mNiKSjYDle?=
 =?us-ascii?Q?GfiZaACf5GQwYUGFnbHGW1Wo8l1hjFAvhCH9rauoYWcnFRcCaV2MsQ6d3gRY?=
 =?us-ascii?Q?mu+qaCtv7J0oAhTc+IBtmL7LMSeKif6OrTVk4xGUm7iuK7eYovID3Wie7ytF?=
 =?us-ascii?Q?CoEK9xl6v7z4sWmcnh07Na42SsTPdzuhVHq2c/N8tH3V3Ruk8/VihqrrjOzq?=
 =?us-ascii?Q?BolW7KkROkgj/1YVMBsh72JETOWDNT6UCjobXoVz3FWGX0dc3GrnsXD3VfFc?=
 =?us-ascii?Q?WtPVOp47TXkwoUc2Bb95TAbxJ1UeYv9y5I1ldsCniWMH30c3n4OputgAl0xP?=
 =?us-ascii?Q?PBMVOF2HdCVEWAyNda/5PHu0BekumKBL/LWs4cupB96oYuO42o1g5DOtv2st?=
 =?us-ascii?Q?Js23u7pEl/3qoxiTkcip26r6KO+kpgCzliXCWKUivZOp2rWKT3aO6+b4EUrM?=
 =?us-ascii?Q?/g4If2Ymw6bOy+5RRX2axR6PdQboU9cwMd8zDyaef616rPJYueVvJKE1jP+z?=
 =?us-ascii?Q?BEzKu1Xc1zDda5tTOap6SGq1pAR6ip2KwAPINpu5cqKnxOGUAH7WcdUqaL8q?=
 =?us-ascii?Q?1+33/b0Ez3eVFcvdzilFx5/6kcet23F8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EKYZqqg7KLEwfy8ikEJg3Kiw0QEOzeLUYgUP4rZzmzUSLsg/C3xPEWnUjoO1?=
 =?us-ascii?Q?MzSFASEQl9KY9wo0Z/NhFO0d0NKC250SDWCJViC742fh0mMlcX8Jx5IMhVKk?=
 =?us-ascii?Q?CMy0VOUALgMRjxVGUDe3cgeBNNNivvY1wXcqYSKbbOHb1gv7VoY9OnLJH4mo?=
 =?us-ascii?Q?oJ++hUXS6pzuTLl5qbjQBhD0Et7SLEx+ucvdwVwRTGhYEstYUKr+sL56ri0m?=
 =?us-ascii?Q?l0EBQYJDyqvlGdaqMYAqsFWfUY8ubu8WdH4u/fIg4GCJSB998uo7XgSemuku?=
 =?us-ascii?Q?jpISHVBQ7vO+Ymh5jwytLg/L+Cu0BDtZ/H4QIYeHE71y6SLBar11yVxzeKLY?=
 =?us-ascii?Q?e5qYTZqSfGZuqqH3BdwSytUuIbS8KnrS2FpJRcxGXbuDZNSZHVFI+ud2Xjod?=
 =?us-ascii?Q?tbScbKoqueu5K1IqtritOrZD8y8SxUnwf6cyF390l4kU/NYIdhO7Jrd2OXfA?=
 =?us-ascii?Q?rNWoG7k7cbd40GYnQTq9zjLZjLH63jyT63mUAYu5R/pmsLbi+5Rt840bC3F4?=
 =?us-ascii?Q?8L7iDEqkLQ0PxGknmmRKaYx77xF6IFQei1It2Vy8VYBLWGaUK+HhKZUcRle+?=
 =?us-ascii?Q?5Q7Hk0TUUnxxMOZa9yyyCJp2zutC2SfsGrq68rg7OZg4tOaNVr13QMOevmpV?=
 =?us-ascii?Q?69QOX0NgKVbhpWO3DmdEpQkvf4xj2KikgYLi0tRPtoa7FMYFD98bdyaGHVJs?=
 =?us-ascii?Q?yBhfzLusmPBeROl3Y5WA8G09vx6E9icEMaibuCrLSklh0RfVsHR5dRhWQP/0?=
 =?us-ascii?Q?fz/FBm2uR3iB4NC2nWZ8IpT9lbkKwYBOWHiHX+/irKcK32+gU35cYI6Ao9gg?=
 =?us-ascii?Q?UqaHxx2j3n5nbuh/JkHdH0lO/gPG4/0KYDvSXYSCiKMSviPUMRtit+gcmj4C?=
 =?us-ascii?Q?CH6OF5Wgq3Bm1Io6BaEn119M50avK3cLLwM4Uv0Hei78J0jVp36cohFG7vSn?=
 =?us-ascii?Q?TQbk31VmnSD20oGZDfg6/GyVBj9P50osPH6fBUwsDHI7LB1lxNnW9eotfM9K?=
 =?us-ascii?Q?HDSpc7ium4Ggiwe2n1wZHtA1gXU6mQ+V7InVn3Y6TzrwjVa4lPFIH0s8+iIs?=
 =?us-ascii?Q?VLpWolTDbpYNuxhI/haTWWNUTaA9XMaG3KhK5mddxw8nI4TxPpbCkyWIBsDu?=
 =?us-ascii?Q?72h48FrMXdzNNEuDb0Gg7ePUhi+1DQBNBIthDmd7n+b73ZBwc0GZg4dAXjBX?=
 =?us-ascii?Q?2ZFIV3UfO5yc4b9chNhLd/brNKXi798L+p7K7olWYLvr03n/+dPK7ycPzejh?=
 =?us-ascii?Q?6WtEGD7ScIuZgmj39AM/ZMR8xmRxaWZ/FnGovfImDhKAI7p5oZsm/ogVrByn?=
 =?us-ascii?Q?fXSIkkNOAJNxfEda6GI18Yaep2e4jLdEThWWeARtwYED4+RHD8xzJ3JhBkLS?=
 =?us-ascii?Q?N7njWaRaKpw+/W2pfrpfPyHUrHSfkIoYNc32c969RdPGvn+KrKCanzKmoXox?=
 =?us-ascii?Q?SMKW6gBLaHrC6RUPmqfg0tuo6pA7OCg445S7ySmC0la294Ti5tvL4kH/19CR?=
 =?us-ascii?Q?mOAGHAKoHPC/+Mf9qXY18tru5Z4eOkhvBQTz3VwXVdptk/Urr/JWtc2mtRVH?=
 =?us-ascii?Q?Fb1O+2uzaoowOjm9fjrIXyWjF9IsZaMAnNF5NWnz/MenpsFxkZduhA5r5FzK?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fe9a7e-4f01-43e5-0fc3-08dd39fe059d
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 09:28:53.8640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaUbVoKkX+MGrc89GogcdxEl2328dmbE30EcSigbeiInLT+6yWPyq3kCr0WjJxOW698fT8f2ui9mYq4Iv7FIJKOgSuIRz9k0Y8xlI/bJEu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4091
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

On Mon, Jan 20 2025, "Rosenschild, Klaus" <Klaus.Rosenschild@hilti.com> wrote:

> Hello,
> I have a question regarding the signing of a FIT image using mkimage. I already contacted DENX, they referred me to this mailing list.
>
> mkimage supports the creation of a signed FIT image. To do this, we need to have an appropriate .its file and pass the private key as a parameter to the mkimage command:
> mkimage -f fitImage-sign.its -k keys/  fitImage-signed
>
> However, this approach does not work in our setup, as we do not have access to the private key.
> The private key resides on an HSM (Hardware security module) that is not directly accessible for us. We can invoke signing related functions via an external signing server that takes a sha256 hash as input and returns the signed hash.
> Then we need to add the signed hash to the FIT image.
>

You may want to look into using an openssl pkcs11 module interfacing
with that HSM. Then use appropriate openssl configuration (set
OPENSSL_CONF env variable) and pass "-N pkcs11" and "-G <some pkcs11
URI>" to mkimage. This is something we've done in a number of cases with
a Yubi HSM.

Rasmus
