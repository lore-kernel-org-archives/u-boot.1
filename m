Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81701D4662F
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 22:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E768483A3B;
	Thu, 15 Jan 2026 23:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="rNIB/wco";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B60082BF2; Thu, 15 Jan 2026 23:16:59 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazolkn190110000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d100::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5999080077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 23:16:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIbKC2eIcQk/W8tZfy1EvcuE+c1s+OEejZtLAJCrH8FRTqKeV8wHP/p9Xw+DCgQ5uF56UsQOqLbT5Ie18j/JQ9BZKSsoaIy0ea2fReX4mdU/cFjapBBYvkwGor+9CycFg6uEaGq6uQjRBYcwBlrKl91tkIKKC0dsg72yHYR4rBZGgr4OxKUC4HPiUizejSv0PW5jJE3xh8BR0BajzIhQcaR8AvYd5ciqjSTwi4jOC/Go2aTxO9mag8q2fVShaJWHvwuYynmBG4gjF6pdR/QW9ILx6Da+DJ1F9BAv8rYDUblQNKKV8TECv34F1NbptToKeQWyMVDjvOYdu1YMbA9wHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEr8VHLQ/9l19xGz4831eMDMdj6AlI90H++l2bciFw8=;
 b=H1ZrsiVAkmBMwstOwD4BKPjYCZszsVH9K+ztKwoqk/fmhH7f+CHpYRdD+IRwti9rbiV+Gfr1wh/UgTQuxyKoKRfRtKqzRvRSWnd2zVza6iVCsgMkTZn1uQfRybsXHlabyRtiUDn//jlS3Pbx7GSvk49mUZHIvo9zovdLxuYJI9ty1fVcIsve0+eW1SsT/Dr3OOS9wA4EC+cICAlOc9Zx+p68FOASdkb3NjzNDSpN5wPunuVpqVZ+BMk6oXjikroZRUGWLzRzFoJsHP3+ZgO7B2XpDzO6iORa+2xlvbwQEn8T06U56zNHkJ9lSSpZMastd0eqMqd29jG6nEEWaX2A6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEr8VHLQ/9l19xGz4831eMDMdj6AlI90H++l2bciFw8=;
 b=rNIB/wcoTgUMyrHOIwL0IO6LyNwsdi/aQMsE/ehdQQjoJSnaUarRKRr5McjJUJYmNQz8dRf5HOZULlFl7EJJ26KPfaRMG0g3mXXTu3ROLJ8YZDX7CS3Wz5WsKp4nP8ty7dL3nMgQmsU4OkNNk2ZkRAsj3WFUtcAJr23bjKliQI+p63BcMnxMZEBLO319bYLidsYtZpiRGnwCVM/oCby0W+jnr9jfe71CiUaXmtiPyUl9v1+PtxgkXZmatFbyRRgj9hMLm0bcYhODVuvIMnRNTPwvvk4zAUFeGTvF09QV1i+JCxRd2l1038m38QJrY2+4q0tCR+Tq4uAC8epEQu2W+g==
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com (2603:10b6:805:b::18)
 by DM4PR19MB7215.namprd19.prod.outlook.com (2603:10b6:8:10d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 22:16:55 +0000
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::57b1:b92:26fc:c937]) by SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::57b1:b92:26fc:c937%3]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 22:16:54 +0000
Date: Thu, 15 Jan 2026 16:16:48 -0600
From: Chris Morgan <macromorgan@hotmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, sjg@chromium.org,
 jmasson@baylibre.com, nbelin@baylibre.com, bisson.gary@gmail.com
Subject: Re: [PATCH] bootstd: android: Fix write outside of memory
Message-ID: <SN6PR1901MB4654906FF49A45C5FEE9939EA58CA@SN6PR1901MB4654.namprd19.prod.outlook.com>
References: <20251223234456.1983614-1-macroalpha82@gmail.com>
 <20260106171633.GI3416603@bill-the-cat>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106171633.GI3416603@bill-the-cat>
X-ClientProxiedBy: SA1P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::22) To SN6PR1901MB4654.namprd19.prod.outlook.com
 (2603:10b6:805:b::18)
X-Microsoft-Original-Message-ID: <aWlnULY1ukLtuNOv@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1901MB4654:EE_|DM4PR19MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: feeb045c-0b11-464f-4455-08de5483ca21
X-MS-Exchange-SLBlob-MailProps: gMiuAN0LASIPtJFHWBzvUtRfhjUdI+tGrccZEiFuIbVeylSyNyZdZCYjIVFWyRj635DTwK9O2RvEqf6GcZFMfYitvlE7KCcM2R7HauDDrqH3kw/IwiR9EWFix6kdhNTtc67zmxPSpqronRrBr76SzcblyHzbytuLjKE20gZebQXXpXRt1IpqIneM/Y4bxhEYuPpdmpbqkqZ3l/1RaTTcwtyfeDHZo7ztKFPY16hmAdpWQ5hvGpTmT1ca82UrnhxtBCi7qMmn75eKF2sfIWJ2noS+FouGO4lWBWUcH4HMpPH9QcWZkPnbiOvhwuQGjt9aVEsFP6GuEfl0xTQeWkgEglLwKWfQbKq3ZdcxkV+YJvtIdhXWCbwUvqKsqh8NSme0Fx0Bhi4pHG+t0eY/tjHcQbHCKte0EzhFWoQCxuyYRu66oMcVV5NOfBKPTzB7gacG3F/VP1srNWX8V6cXUPhgNeIbANaTUMPW/2vAsIPkvnqX0AiJytJzCKmGFzegk+giuhdoRUPT9h5GieebalHqHbzwn7TClAdZaug7rRyOT7nLaoQhJXJC/PSCCU2SkuGRhM9QP59hMjK6IYZEgPAmR+MxbV8r65NkwgTa+0cmBe3HPgXwTe6jIzkQp/iIuZeuQ6B3tmt0zbzB76AsfymMFW2DBLFJi1Z921QyFG/gQNtVsDU2yVm5QuyXjzFizt6nkYTWR3tUY2mAjXchGBkXeQ==
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|15080799012|8060799015|19110799012|41001999006|5072599009|6090799003|461199028|3412199025|52005399003|40105399003|440099028|12091999003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fy5+A8uRemW+UPasu5sNWu+PY1146kd/FeK0RWqkM/J1nXtk6g40joGWKD/y?=
 =?us-ascii?Q?2auY0AGodRd+vkicQ+Uo2yHUZKbPwngJEq6Xo5Ep8ZyUdHKg+ujiGxbWGaP4?=
 =?us-ascii?Q?IyaiZEbH+uQfni3jZqrW63eG5YIQKtfg7V4en5A4K106BzNxUr0V3+WQaot3?=
 =?us-ascii?Q?5DM05Aui8T9m3rBkJ8rCDFO73q4fcN0n9Hab+AvK69m6Wk+oKpgBzFX8rENI?=
 =?us-ascii?Q?J3O8+DdGRYtxTUDQpZssIcLfVJJOujkYcAgd6aK+fdFXBphj3CGLfv2xVg0D?=
 =?us-ascii?Q?kQmIndOSbtFtCY3ixo4J20wa4SwMc9PfbDkl+OsgOtb72o3UaPbs2rbvgotB?=
 =?us-ascii?Q?aWpbsIMl4J2kq3+EV8JErD10wjrH8Cgb2pwhz2A9olqWWUP3NZWcsjrgEOyF?=
 =?us-ascii?Q?Uw77urOtrfTOGfogxPSXd0/HTHPVr/BuZyAJaKDaWvAs+Df7nxzQuIZb+Mhx?=
 =?us-ascii?Q?ylf5RQACEGc6UCmYW2EFYIFgyQo5ktrjNFqbokIJSSl1IgKQ8bqIimCKUr6a?=
 =?us-ascii?Q?OYPk9xi4iAMPlG3whmk/LMApECeZqPUCVbySX4a1+H08SlFtRfYKDg4uMjjF?=
 =?us-ascii?Q?MVGhTnyCP96xBHysproCsbFDNTpil1zFlyVPW8puqkkhTT+IgUOCisbOXi/N?=
 =?us-ascii?Q?wHGaOeZaODrDRAmSRFWwyyz5hDQ6k+HV+7ZsJbu87We8zqSmMfwMwBh34dUF?=
 =?us-ascii?Q?MsdpkAn+7udYW7sPR5g0WD/Y0SmymomqT/gDuUhczTf1zqDT7shkij5m5Drw?=
 =?us-ascii?Q?tkms9afcLCKwRaRAtbi9b+cbBC2+auXg3+ZLFtbKHqqgYHQ5XH3uOCCN0yGS?=
 =?us-ascii?Q?Yvx1x5yknKZ+RZuItnQCG8rpNZC+WO2wpe4/7lvgUhHZFEmf6hXmLyjW8izQ?=
 =?us-ascii?Q?ly1ya9/XvH2DFdr/nWkeUketE0LFKaKv7yM4qzmhDy2hVIljQDepxB3psbxi?=
 =?us-ascii?Q?zE1G1QY9MxSskcFZ4VfpJqLUvlp4e4FJrgFTVRLFz990HivLlrLYkatGh0pE?=
 =?us-ascii?Q?7s1pBz2wv2ZDdveg6XmlTRbj09CrldhdxJiNrTMOWuyQoc7BBNvVtcE8V0ED?=
 =?us-ascii?Q?NRCXLtY4aFe+vCUvDRzDoCPZfjLecBPddy/ZkSPnu/8gLnmA/vQJD9SYfkWw?=
 =?us-ascii?Q?I1nty/VFxyupcfgjXCtRVtMn2yDizshL6rNKEAO9r8xsbU8tcRX3aNDGzzVY?=
 =?us-ascii?Q?AFXGttIZgEp38Xg7NziT2UdPdOV7H/al2yCm5x8C1jkmECKEqJZRaVEcVeGX?=
 =?us-ascii?Q?KtttWjAL8Vn/XsSjJ+tsd4v4d0ni1mVs2gQrOQ9ldw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZQz89haTzYMIhdYjesv8vg/Pj2LiV85V+6iykfsMwCtxh2URuj//Y0B6SuzO?=
 =?us-ascii?Q?+/BQlQK9EnWSAufDiWij8JdeelbthN5mDvAre76TuDkevLYRNuSkV2xdtJls?=
 =?us-ascii?Q?08BlgyCmxnjzYHWpIejm4iKSPMvG9nFo9xDmrZPUeAHCce+WS3t61QJBROnN?=
 =?us-ascii?Q?r0cg/sjiA3hm8nJwHcJNI9eY/tDVCHlMgwxxJPjzEwjQ/UnBnnMzF7J71Zle?=
 =?us-ascii?Q?LCJuxbR6m5AfsLFOU0Sty9KrzcXz4vJZ62IUgqNxJ8Pk/t5qAxpd0I+CWbRh?=
 =?us-ascii?Q?iuDVkHwDiB/WKxRxVoC14GOdEiw1Di9zxqgUW8Cb2MWv1KA0jWWLQ5rHD0MK?=
 =?us-ascii?Q?QPRGoWK5vRjNcGuch7cyY8luqaPq6YJ5RAP6okMtjeuc45ttRsXqNovjGF0l?=
 =?us-ascii?Q?wwpx2nuoQw5EN2GihhQIquUwPMOq/ZcD8iuIKfUrxmRFFjYmYpiDrH+1s+Rh?=
 =?us-ascii?Q?F3hIX8sHtq31ZnJ93K0SalZE6CaLGMs7/uzn+1XuxgexJRIyCCt7ducy8O3F?=
 =?us-ascii?Q?mU7q2p+CvQ1W5lv8WTgNNXMII6lnUc2LnufSc3mfo1FmLUT7KIDWN+NB44yB?=
 =?us-ascii?Q?NNF5VInUN+cU5+hAnECiEEKeXOvJSZZ4roE/ZAxu+RnyY8n0DX0u3c2ReGqt?=
 =?us-ascii?Q?OBUj1sW2WFlTMam8auYGY7TUkqjbkvahzsfgDBY7BuBzsY+R64XQp13DPVYk?=
 =?us-ascii?Q?8iSL55WJatebMxFvY/opp3pY9OHHUd9RLO7kIPxFiJJdMgjoUe5TKy/BRBa0?=
 =?us-ascii?Q?hyOk5mqTszJvDENGexhJuKqmLC0hgqdmxqhLTWSHauVqVcoXP8N3AE/FAmSb?=
 =?us-ascii?Q?vT9j78IbP419vstz6F8mNH8QA65GcssvWGa8DUfC+9Z8c7JH0gCJ4Bg+WByH?=
 =?us-ascii?Q?FCW4hrwxOhQXFA09A4OoLKRAGNVYOeYFVySjrnlZuJWw+SJL9fDAuxigTEdt?=
 =?us-ascii?Q?gkY96wYBpgCJzQMerxJmT1vESPq860EeYD6HV2ZBUfj6BeH+Q4v/Lf+MLnsu?=
 =?us-ascii?Q?FtbOxgEn8iFRFhJd/rohvH2l0uWLdIRFJrQEahQM/JE8IsZJ5/s+ga6Pi5Cd?=
 =?us-ascii?Q?mDKjha7dwlkeZHoZDdA1YUp3nTIbT0UtQD2PR15uUCMiuy+ARLNZ9vBsCSD4?=
 =?us-ascii?Q?7QgfPyVZC8+MWn1cURHQiefBy0QLT506tKrgUOmriXMZdXHE0YUHM8EF1VoU?=
 =?us-ascii?Q?RyrTUwJpcXojBqggiJ5Hv+N7u1ABIlPvg8Z5df+rZVgvyr6TQ1hG0pVwO+uj?=
 =?us-ascii?Q?U+lbBjHizBp1J5abr4IXhyusw0Evv8msCmj004kGvZqeLr+Deu0RFnLMMgGp?=
 =?us-ascii?Q?zKpxNJnxRGJeHGYPFWdKSMWsX96aBq2Dc1UMFN3pZvi0Xz9Hi/SvtBHGcPjV?=
 =?us-ascii?Q?0Vd3PbdTjYslPC/yuwtfS1t1k8yCbDja3IvCKOmGzs0hOitAGA=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-6f20a.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: feeb045c-0b11-464f-4455-08de5483ca21
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1901MB4654.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 22:16:54.6630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR19MB7215
X-Mailman-Approved-At: Thu, 15 Jan 2026 23:29:05 +0100
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

On Tue, Jan 06, 2026 at 11:16:33AM -0600, Tom Rini wrote:
> On Tue, Dec 23, 2025 at 05:44:56PM -0600, Chris Morgan wrote:
> 
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > It looks like under certain circumstances when reading the vendor_boot
> > partition it causes my device to write outside the range of memory
> > available. Near as I can tell this occurs because
> > scan_vendor_boot_part() calls android_image_get_vendor_bootimg_size()
> > which calls android_vendor_boot_image_v3_v4_parse_hdr() which calls
> > add_trailer() which attempts to copy information to a buffer allocated
> > with malloc in the scan_vendor_boot_part() function. On my board the
> > memory set aside for malloc is at the top of the system RAM, and given
> > a large enough vendor boot image size this causes the write from
> > add_trailer() to occur outside of the system RAM (nevermind outside
> > of what was allocated with the malloc().
> > 
> > While I don't know the absolute best way to handle this, I would assume
> > that if we simply map the memory we want to use to where we will
> > eventually load the vendor_boot image that would be the most logical.
> > 
> > Fixes: abadcda24b10 ("bootstd: android: don't read whole partition sizes")
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  boot/bootmeth_android.c | 20 ++++++--------------
> >  1 file changed, 6 insertions(+), 14 deletions(-)
> > 
> > diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> > index 1374551dbeb..c2c25d53ef3 100644
> > --- a/boot/bootmeth_android.c
> > +++ b/boot/bootmeth_android.c
> > @@ -118,9 +118,10 @@ static int scan_vendor_boot_part(struct udevice *blk, struct android_priv *priv)
> >  	struct blk_desc *desc = dev_get_uclass_plat(blk);
> >  	struct disk_partition partition;
> >  	char partname[PART_NAME_LEN];
> > -	ulong num_blks, bufsz;
> > +	ulong num_blks;
> >  	char *buf;
> >  	int ret;
> > +	ulong vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);
> >  
> >  	if (priv->slot)
> >  		sprintf(partname, VENDOR_BOOT_PART_NAME "_%s", priv->slot);
> > @@ -132,28 +133,19 @@ static int scan_vendor_boot_part(struct udevice *blk, struct android_priv *priv)
> >  		return log_msg_ret("part info", ret);
> >  
> >  	num_blks = DIV_ROUND_UP(sizeof(struct andr_vnd_boot_img_hdr), desc->blksz);
> > -	bufsz = num_blks * desc->blksz;
> > -	buf = malloc(bufsz);
> > +	buf = map_sysmem(vloadaddr, 0);
> >  	if (!buf)
> >  		return log_msg_ret("buf", -ENOMEM);
> >  
> >  	ret = blk_read(blk, partition.start, num_blks, buf);
> > -	if (ret != num_blks) {
> > -		free(buf);
> > +	if (ret != num_blks)
> >  		return log_msg_ret("part read", -EIO);
> > -	}
> >  
> > -	if (!is_android_vendor_boot_image_header(buf)) {
> > -		free(buf);
> > +	if (!is_android_vendor_boot_image_header(buf))
> >  		return log_msg_ret("header", -ENOENT);
> > -	}
> >  
> > -	if (!android_image_get_vendor_bootimg_size(buf, &priv->vendor_boot_img_size)) {
> > -		free(buf);
> > +	if (!android_image_get_vendor_bootimg_size(buf, &priv->vendor_boot_img_size))
> >  		return log_msg_ret("get vendor bootimg size", -EINVAL);
> > -	}
> > -
> > -	free(buf);
> >  
> >  	return 0;
> >  }
> 
> I haven't forgotten about this, but I'm hoping there's some other way to
> solve this, I'm not super keen on adding another environment variable
> (that would need to be documented in a v2 if we can't fix this some
> other way). Mattijs, do you have any ideas?
> 

Would using hdr->ramdisk_addr as the end address in
android_vendor_boot_image_v3_v4_parse_hdr() work instead of (ulong)hdr?

That of course assumes the ram disk isn't manually loaded elsewhere.

Thank you,
Chris

> -- 
> Tom


