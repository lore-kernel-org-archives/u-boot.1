Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FCA606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 06:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EAfKP0mw;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hukSBeNy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4661760A77;
	Sat, 24 Oct 2026 06:41:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xoNnPMhTSvSz; Sat, 24 Oct 2026 06:41:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 402E060A59
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792824094;
	b=AENJ4qr4NO6/wej6wjPYMX46T9NxERJfjouS68K7KFToFc/w2ANDIGf+I3RTGfDwh9Vf
	 kSrGooVIWxrsxShaX2d3yWoVdBqp4vJi5S0ncJ6ysJ/1DtEZJS//lG2ffZdGm0+JS0yUR
	 hcPPMypCIyIUFpOpDM/AuVQQS7dGOzmGfEaiBsl/8ymFZUkZSk8rfJYW9TmgM7onv+A6K
	 sQZvjNbFefN88nyPNDFEI8QRjv9Q+aiHGg+2HacJS8f3aB0rwWgxypVGJ3OypcKoLF2/f
	 tF2ognQVhW//H7m2wPHyhTU8akRpo2EOR5qCZn+3/62Kz0IFA3bZOrjNllYFmwOUsmw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792824094;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tlDn8/0B292tJD6igizJ9Uam4ZKYlrbcXv/ofi/YprA=;
	b=K2puJCM29MvGb75VETtPhQq5Gyt4EEP/KFRB3zJrwAb4u4QC2PUAZ/DAtnuUmaGUgBDU
	 XxD774uk8loNbktnoGtAL88poQW3JvNXstzQ0kP4TwFwHdGJqP6ja8LGTQoP2rge3AeWI
	 qZ0jDnROE6UYqcpnPrY71E4P57ce7ScNUqqr/gSil8qd/hY+DGuygdcjTB77ztjCWq0wv
	 SZkpoZKaFNQRv2gtKcTFMD0ax/9CHrjMh0ccO4fYHsV1taI2ZMhFt9bup7w3BPcK7147a
	 jbCCAWJtafIa0NkSjA0jQfCmkMyOF4f92dPd1ILYvI0m9llMkMLcpnkSN9UFJbV2/Fg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792824094;
	bh=tlDn8/0B292tJD6igizJ9Uam4ZKYlrbcXv/ofi/YprA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EAfKP0mwKqCncKrhGvslE8u/ygL9CyDTblGWR0PCVLB7i2krS11AksJrPMdMvju7s
	 4p9XbPlh/yk/y5ugCWULE6aUL5bGKIqdGaCqifFhA+r6rGQNAN8eeSIj899Xl1ShGA
	 SGNZMy75lWHOMrwZdyceBoAAtULupSfi3Axaj3OqGzhOQvTBqWQ363df6N7CQDm/F2
	 Z+ub4jYl0BLGR/3JYYNA3L7y5ixc9dQsY+KQqsCIPdN7HNMpFUlEXA4n8cCSGkKUCf
	 ygREFvB+HIhDukM/pVJ3XNeRXhTNdIXKOribwnXVo2NC5wvBXQ57SPaPoD+HHxkpLW
	 +NjKCHtwnlAxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 402E060A59;
	Sat, 24 Oct 2026 06:41:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BAE44D1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D741400AF
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:41:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gy8sEQGyO0Ea for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:41:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A511340068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792824091;
 b=g6qOE2JvvNzjD0PFU+3ApqwTOJ9A5ROsEEGlUaC7m/71uwFG/+nX3ZqSeJErzD9VeOyJ
 2qMvGFVtzmt+pxV7EFmyDnF8DEcPEukPMdxVU78eP+uJEht4P99d2PGOnnBijsfqc2UKE
 PUVJnYTgUyDf5c8NHvb7rzKSsEtG3wP6IqOEEQyeZM538N00mIXk5HmJQywj24alLUAbj
 vhnNyzdBerUpijuG/kt9Ff/Ie/PH6Nx1L3YkhvD4cV3t3tbmHxLCEPPyBz+/MVUW7ZVS7
 c9VWvuetuZnXitAzFHTtoqislD/Ke2bAfz8yJo04Q6Fq1FHxPYFxTmFAygGYxnS9PtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792824091;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=tlDn8/0B292tJD6igizJ9Uam4ZKYlrbcXv/ofi/YprA=;
 b=tA7WX8ykoNxzApPD/fDE44n25Dpyu0CDyhYMRJzhbevctX4VsPa5PC1Hy18Cw2hWFnUJ
 jmhvEYV7R/EuDIz3DQzYAKE0qYYI85quOLlIYt/00+AgAETX8FU5ZysHCr8FKj325mW5M
 oPcY+R6pSkEuDdYK0vq5nOCuRGGya99dkBb8Nd14RHauYJCKEYKpgfsqz+aDmvGPUKEkc
 nrP9KInwsmTb95PBPv+ipgYqyIUvLbpvEqBXqTfCRHf7kAa7VKjE6/AOr7x2KMc58Z5UA
 jljJO/msxGyB+esxMeGeGoN0VjNPsmPIfmOB8HqepmUVM8mH7UI+JzHFDE6aZ1Tn6Bg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hukSBeNy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hukSBeNy
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A511340068
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:41:31 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3acb11973c3so1060310a91.3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792824091; cv=none;
 d=google.com; s=arc-20260327;
 b=hm+3Ztj8CP8XxkYCI+jb/z3iziJK3PfoL/yPpA86A1O4pj6fnMyy7u81EdGWcV3j5O
 DY6Njb2iPYHLNeeisE5xFEWHEOwLmRsUULuYeTxTvfMB3Wo6Ry0c40UJB8zw8CmsaBVk
 hZXlqNwF4PN2pRbPMnZkQXMQBe2jNgnVSiUgNhS6DS4JF/erH8jWC/jPjeN+EG53LznQ
 mKWudWhq6IijpV7p8rYa/Uz+bmZ532KMxXF9Ss+RYfpJu2+mnPZ+VVOKAn1Xh+RJUbA8
 Zr6/MJV9jkrtK4pvD0ZIdw7G0/hX8TvaCWeXabgoTT32RX8vQmHjPrEhj6qUDN3ypENV
 Ltww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=tlDn8/0B292tJD6igizJ9Uam4ZKYlrbcXv/ofi/YprA=;
 fh=L/uw9+u71ZiDOqmjlybLnHPNPB0oTVqkdjWVKnRfXQE=;
 b=LBrdf2MFXOqAC6AP49U4N2lsLXza3rB8gcmKDZTKPT9Ise8JzHv7FsU+NyoxUCMVDv
 pj0rXZbxMVDWPQVooH93LbeACqMfiBlmbvHD7MirCbJgd6RCMvgJzED4yU7BVtJtc+tu
 qBVDlNKjpz4zqxChKdaXhpmSfr9hF7MYn6CstrPEjSpDGxUS5+U7nQePuhr9CYoWGvv8
 b2OY+X7dGJ8Uxa3pOaViYv9/K33ulNgDk9xlihpwTtelJnbmDbRtLcHAnoyH60n1Yrrr
 YJNda5CDCUgQynzDo8/s07snwCSWBR47FwVv5GWfJF9tylJ7pXM2/g595p5My8UxcZzZ
 GGIw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792824091; x=1793428891;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tlDn8/0B292tJD6igizJ9Uam4ZKYlrbcXv/ofi/YprA=;
 b=hukSBeNyIS4jXI0RXda40+0F5O4piJuljQsu3c6J6SPNpbyPTpJv13IZjNw4k4lUN8
 y9tBpswrswEwdZ6OYTpnfqhjx6bGwGVzmbiYKAVns/gGzMr/4mT/ilD9aO2CVSzcQeFd
 o9DKGFws64WjbKbE/SgHsfVk2EPQvafSh43JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792824091; x=1793428891;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tlDn8/0B292tJD6igizJ9Uam4ZKYlrbcXv/ofi/YprA=;
 b=qscFO7EsmqXV3zzSi0e7RtnN3ZO3uvqddz+BDtuT6woI33hAOq94flNlKg0PbfSY/i
 6f/phw1w8b38lx13FQj2ija7v7dWGHkoLcjZ0TrpcLcm4Eq1wWP+Bwso3kSPw9c7tit/
 d1ukEkv2qR4uu8rFNL1PSvB0+i/4dKAJ19XGLv1CQ6PbF3LW8ycQMDCfww2s0lFV+QYG
 sXteVpE8GB/SDI2lnlsZDLTyuTTQmws/5jQbkBxdyQ2P+2pSO3IActygg0zIsqYJZAE2
 uZwncYA3aELffIYbA4F9rmp10gnu2w1vjXSPDkPlzK4N26ocBLz46a6RuKBEQxDmo180
 jPcg==
X-Gm-Message-State: AFq9FYJb0+EeQtnGBhWCwqU+ZSZjD2vtmWqF9R2MMb6p0oyYmCMENm9F
 XNBhcQSqWe7oJolIQs+jJag+AqxazrQ2UFyD4FtxT/0dAwt9+buQnrbu97EsBctAPpOq/T8iSMD
 0GX9uXfAVtp4rbTVQqIAvfQMxDGe13ItUSCYhEO0rd2zOaLnhcXplTQ==
X-Gm-Gg: AYBFou0Mj1jik9Xkg3ohcGkkkOeVNVAfHLkt72C1zq2KIH1ylFAalKKJGMV9Ql+Ij0Q
 P2lknREeLINFLXD4zduWtbxGvSY2T2xrWSZwfTBI/nunwMTiO/U0amFz6tUAokTDgc+PbQN0d5n
 pjRFsUF8U/bjxDnUQqyvR0BqANFwYxFl/IvT37adqrE6nkn14L5rrX9SjlL7CI5ZUrQHsEb8jcG
 9VTC91GOUan6BN9//EIoQgeANMHHNSZ5JNcrLF0N/TFVdo+uNLE1AWZHg5BSxhm/Mkw90FUKuRU
 NpnAOLTLGYsJVygZn/y+afyHAW1QMDTOzutJzz9yop3/g6wQqeMPCfLlt6Bebqwpc+UYXPaMR7Q
 RXGpz31qwJ1MxE+ednRfNonFzTp9zWJBpFTU=
X-Received: by 2002:a17:90b:518d:b0:3a4:f75d:d194 with SMTP id
 98e67ed59e1d1-3adeafc4717mr1119893a91.36.1792824090477; Fri, 23 Oct 2026
 23:41:30 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:41:28 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 04:57:53 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261022135740.3869144-1-padmarao.begari@amd.com>
References: <20261022135740.3869144-1-padmarao.begari@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:41:28 -0700
X-Gm-Features: AclHuK_Nq2rwp-w3NeevWq0Lxjz81v0yI72tHma0Sh8j67Xp9L9n_gfWqTi67_8
Message-ID: <CAFLszTg6W7f3ou6-y7C5G8hvFdsdSTwpJj-g7BjN4X75bcVZ+g@mail.gmail.com>
Subject: Re: [PATCH 0/4] mtd: Add MTD virtual concat support via device tree
To: padmarao.begari@amd.com
Cc: u-boot@lists.u-boot-project.org, michal.simek@amd.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Padmarao,

On 2026-10-22T13:57:03, Padmarao Begari <padmarao.begari@amd.com> wrote:

> The implementation is based on Linux
> https://lore.kernel.org/all/20260204-mtd-virt-concat-v17-0-5e98239bb55b@bootlin.com/

Just to check, has this landed in Linux yet? The binding is already in
dts/upstream. If the driver has been merged, please refer to the Linux
commit instead of a lore link to v17, so we can later tell how far the
U-Boot copy has moved from Linux.

> Tested on a ZynqMP board with two mt25qu512a QSPI flashes on CS0 and
> CS1.

The last patch also enables this for Versal, Versal NET and Versal Gen
2, but you only tested ZynqMP and only GQSPI gets the chip-select fix.
Do the controllers on the other platforms (e.g. the Cadence OSPI)
select the right CS for a flash at reg = <1>? If not, I suspect those
boards have the same CS0 problem that patch 3 fixes, so please can you
either test them or enable just ZynqMP for now.

There is no test or documentation in the series. Sandbox already has
SPI flash emulation and MTD support, so please can you enable
MTD_CONCAT and MTD_VIRT_CONCAT for sandbox, add a pair of partitions
linked with part-concat-next to the test device tree, and add a test
which checks that only the concatenated device is registered and that
reads and writes across the boundary work. That would also get the new
code build-tested in CI. A short doc under doc/ describing the
binding, the naming of the concatenated device and the interaction
with mtdparts would be good too.

Regards,
Simon
