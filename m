Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A3CCA9EDE
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 03:30:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE8B26070F;
	Tue, 13 Oct 2026 03:30:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hCjrwx9Eh7Ab; Tue, 13 Oct 2026 03:30:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F2DE06066F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862246;
	b=EKf6tGZJAd0nJ3ZYUNX9f3HmRrZLTSSmqJKnYb+BYBZL1qvtWJ3UyuYVKAS7ZSWIcaXx
	 ISHNLdlrw4WzO8JXpEqDsLKIOoDDHrUZ11q/kR/d/c2srIh6aFtpFNVJVQDQqk0vC8Ibo
	 ZD5SYJD72nPblLkJXwHDEzXkrBkB6lgNEn8+lndUjB0Rp+XXOuhcAboOVgCQVkfWNTs8W
	 G3MdB0NfVNDIBXXVjtSyDWysU5Gv6/Epuk/wSuHfnNaVsHBAk8346i0vSEKQc6VysPFG6
	 37MzIXkAG2YQoNdXO1sSl974ZeK8A5oodEMEmBkvKr/avY+Y76xab2UG8kQB0iF9hSQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791862246;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5+myLxei0DrwpchrD7vPBT2X99/j9b3NLQSDp+UZF+k=;
	b=ed04bO1n3MreN+bgi5QPchlzW6ILLR7LKv+9CNw86vZ8IIZcy0TradpreazbSPetO5YY
	 3vpE4+vi7REsOOA1TANw+wxhzlCdIKSQpRim0d9tbm46G7WFfkjmjkwYRwMdbyp/ymXmL
	 oq2Sj0LCJHHjc/tUclASxjFyNxUaqeCe6K1U+WljzfHL3XxWk3SNzq66xN1up1XEVXpXx
	 qzrZVWVY9VKM5o3XZfjJIiDWgkpf5EcTP6oKhgKsb8KaeAXoJiFADX+XurU27EAE1H+zN
	 jBnwQv5dJOGB/rZHICWGZqjYQHmx8g1rjtRAtlBZBdcye4SvGKTVEJzx79FU/IIL9Gg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dTyonq1O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791862246;
	bh=5+myLxei0DrwpchrD7vPBT2X99/j9b3NLQSDp+UZF+k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cnaV4K/LpZW7/5r+vVFE/hh8xPaTtGcS++4ZKB6t6a0Woc1cw3pqgG4cgLcZ7LHdv
	 aEf4hy+qO3E81t+7/ORKaAgUegKH0kQnZTb/1IHULnjHndjrbAe4JocWffopCohXcR
	 AhqEGmeANKUV2HiQRKrurvMAfLsfUgn67BjTHXx1/iKzdlADoMUTKGDshOqeicJauo
	 D8s+eV8pTRL+CpltVs/hBDBJgUBFwe3TY2waamOIv/W0sb/JLI6K0Hj+iH7ZqAVtT7
	 dwXSD/w3Lxq1Vf8Du2Rq8soV+bH38IyNuyATake5E+nDjYFZLz2LddZt6/F3974v9M
	 s9dhm9lb7baqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2DE06066F;
	Tue, 13 Oct 2026 03:30:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 645884DD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:30:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 562A86066F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:30:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dsZR2zZJp96H for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 03:30:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6C7FF605DA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862242;
 b=UivIBNx5CWrT2YzqYNZNSnb9Iv0qf2reXI8JOhNMaEevyjnYuMAzglH7aixYOR6e6Kw6
 N9G8/2YdoAwLHsCpHIigOBZAlqhSfEvm18Z4uHznZyUBz2T1nNOhWAl+sKVqC3MyV7zBZ
 y28atg86u4/iY6ZczOkWLeyowiZ0njIGb41XnbFiSAnxMSWvd2ZoUc4AkU7nWKbJQY6B+
 MRBV4w3n+SwlLTdtInKZIBUcuNhuGmdOFdAVHU/dlaOHKUpgAGHSze6hRYOp+30aX0QWh
 ICCkkllQfKY9ce/VZxwKQSKMEfIBMymA8a+A9c1bx9xf1cKPxitAHhNTkNh2yUhN3zg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791862242;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=5+myLxei0DrwpchrD7vPBT2X99/j9b3NLQSDp+UZF+k=;
 b=XtQ9FXhuC/WjGdnDkuEzSuTsqF1Med3GLfnLQQuCYGt6lnu8IjEB7yKo57EfQ7hHvc7v
 7GEqFs17Cw8MURmEZ9YxI/HtD5E7Z+Y9l3Ij3ccBS+OmdNbK71eZB8tFYKoY0fhBRwG/e
 MKddu7/frdkG8ICxSBykiPP9zEVbL6wciSEPDlTO7j2yaR6Omo1uztHKruuY1UfwfMZ5X
 CGWcUOB2xXqbtU5Ie4R7c8EP4hDMI1voxZcmJT85GF1RI7qZZsBecxzMBS3yYIivsyexD
 1d/zfx+gAvfpVh5Y9/WDO/zX2Ujw7XXHmDCS42TRqiw542A5poOZMKQxiC1XJqrEcwg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dTyonq1O; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dTyonq1O
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C7FF605DA
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:30:42 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6afa651700eso3648155a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:30:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862240; cv=none;
 d=google.com; s=arc-20260327;
 b=ruEENYPh3fZCq1pixSTYpgoydzlLuQo6RmIEVrhwN0h2h3BzzjVJiJbiZOl7CwaiE9
 oBt2QDaKHq9QNTEKWhOnjNSc5hN3q20gCwGPQwNYwSaxcb09yUU0YHP0hxPWvYZSjsDf
 dz9XEs/fB8DXvdSZclqDNxW4KudoGS0+ffhX88/AP2Xj8eriibghKUd9ZolEfYrQjAoS
 faQG1rOJlCR4STX1fh14hET3ukb/V2H/h0/RWRewJ0g4ra7Xwg826pr+R04/jwySib9v
 MlxXPDnDhdUQTJaJUxy3FHLMyzs7FGn5r7YE6ZGAL0OSnNk8wQxRRVdznKX5tw8gyuAg
 H/Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5+myLxei0DrwpchrD7vPBT2X99/j9b3NLQSDp+UZF+k=;
 fh=jP0SZ0MiY4y0YtrKukCuw+acppeCNQSCPkD/L+bHOWw=;
 b=SfOtTasD5Bq3na2XF0EEUeRFiVMpvVNVWD2IYfbVmz6Fy3NEMVLshJIkC5tp1EWmKC
 /UCkaoIqQkecmlxwU4Im9ogLBmP6Twijo/YeYjvuEdFa/AGXswOOFvrhOQ1VVn06lMa3
 PJ/NtqYXv6+NayDT9IGIIDJ4gII3+qj72qNfeL7BKhkQXyQrjmNJK94hEoHwzaZZYV5H
 qgtESjajpH4ddzU5s08qUG0IrdgOYFwCcEe2DUYjExceUDtRT0uPmZzyGU+nQu0k+Omx
 iJPkzSM6nm93pJcrQt7Yfampw80RLUb4Qo3HqoeVduQbsiz+wTfUdpBSHtEv+4X/i3xO
 CSww==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791862240; x=1792467040;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5+myLxei0DrwpchrD7vPBT2X99/j9b3NLQSDp+UZF+k=;
 b=dTyonq1OzHfkNLBXLx1H5gvIlXo/CNJvAaw/PUw02Kl5nKFr/al3K2vEOyWy4OAWgp
 uZz/2Sw4PznDbP7hVgeogjpzBF8mEXPjkapnOmu+VvJYhneDMESOZ6y0ercUiX2tf6Xe
 UlbsSmIryxVgpWs1t38yZUJAYs/zlV2LaUGT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791862240; x=1792467040;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5+myLxei0DrwpchrD7vPBT2X99/j9b3NLQSDp+UZF+k=;
 b=O+piADbHnxoDT9AufZ5Hxf9eRPHh1JdmsoivEyfBmQq/pkZcX461tpIx5w+wmglsjn
 Hujd9fMT8RgK2mJYM+gwiAey0tkHwwVzV0tQCeBFEYj75OC/+NWy8Qy2Nd7/5QCogdDn
 1Fszj4spCbSN9t9BpyGnLsby3ZaRidPR4HzKCs6gpoJfmOD7WgsDCWR0jVdW5XQy74lO
 E/d+ze3fnHKnSUF4aWIVB2SgtMe9mkvf7QP4Fn9HbQQrLDRw3c8Ju6iO+V13+ZB07Vg2
 jJL9bBWt7vIZbA3yq9Ep2b5LHItQI7e0VA+zptSEZ6hgbuna48GzKpdOxRwjqUZIyQR/
 ZmQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHUGj1/HXfHHuCw921imu+gjYccCOKMODV7WhSGrgmw59jVCBTB1LFP4vvb3mVMEWJCF54EkQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLlWg/71pfP3EEJWT5Y0sikDR0YdbqQkBIlSd6k+TcD0zwyC415
 gha2Wg/9XqgBSvkq26qXWNj39VniUA/sjaUBY8FzXfqpU4oZDJSiXvEx+oXk5/vHmoz/mGbspfa
 /3LZhpARkk5kRuQY36sfoXIrk+YbPJBQDDhh8KMVl
X-Gm-Gg: AYBFou0wJJlXv2HotXG9g6X4lRsrHqI1MiK5XXfMUVXgwL06eIvVSQh2UApwVjsr67K
 NP8mDGhuc0jLHf4oTx2Pkch/1LmQsqx/MJo92wD1FQWIiL8lv/ZWzcxdvJA/uded9jRPeH7qmku
 +c97onzo3ihKs0ExMVqlqGAikl4zhNFQ3vB0zg04BNUAuqSls4H4OWsQyyfGSnfxjqG/z0cA774
 5GxH67wQ4mCzq/dcvylbQp+CbsY2UxUz+SUBdVR5ZTuk729UqGwUxPZgq8b4VF/BSoLncq6shxW
 TN025IEL2sOzxvjPMabsJb/KdMbu2pFXwPNnCTzUr62M8woYgYbOFnqq
X-Received: by 2002:a05:6402:a0d6:b0:6ac:a862:d8ce with SMTP id
 4fb4d7f45d1cf-6b17c2389e0mr8370776a12.7.1791862235262; Mon, 12 Oct 2026
 20:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
 <20261012140048.214059-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20261012140048.214059-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Oct 2026 04:30:19 +0100
X-Gm-Features: AclHuK9VPHxmBMUsd70OuKT1C4KOL3Hvezn-GuCiz0_ZVhQam8yovIHjrzsHRKU
Message-ID: <CAFLszTgHzLZrr_2orNJFiCwG+Gp_g2=doSPEan5z3CxsSh4wRw@mail.gmail.com>
Subject: Re: [PATCH 3/9] fs: ext4: print change date in directory listing
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Huang Jianan <jnhuang95@gmail.com>, Daniel Munic <v-dmunic@microsoft.com>, 
 Tony Dinh <mibodhi@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Vincent Jardin <vjardin@free.fr>, joaomarcos.costa@bootlin.com, 
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org, 
 linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Heinrich,

On 2026-10-12T14:00:39, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> fs: ext4: print change date in directory listing
>
> Declare FS_CAP_DATE in the ext4 fstype_info entry so that fs_ls_generic()
> displays the modification date alongside the file size:

>
>  4096 2024-03-15 09:30 filename.txt

The subject says 'change date' but the body says 'modification date'.
For ext4 these are different fields: i_ctime is the inode change time
and i_mtime is the modification time, as you explain in patch 5. The
code uses mtime, so please can you say 'modification date' in the
subject too? Also, the example does not match the output.
fs_ls_generic() prints ' %8lld ', so the size is padded to eight
columns.

>
>  4096 2024-03-15 09:30 filename.txt
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> fs/fs.c | 3 +++
>  1 file changed, 3 insertions(+)

> diff --git a/fs/fs.c b/fs/fs.c
> @@ -261,6 +261,9 @@ static struct fstype_info fstypes[] = {
> +#if !IS_ENABLED(CONFIG_XPL_BUILD)
> +             .caps = FS_CAP_DATE,
> +#endif

At this point in the series ext4fs_readdir() still does:

    rtc_to_tm(fdiro.inode.mtime, &dent->change_time);

Without le32_to_cpu(), this patch prints garbage dates on big-endian
machines until patch 4. It might be worth moving le32_to_cpu() fix
into this patch, or into one before it, so that the data is correct
before it is shown?

In any case:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
