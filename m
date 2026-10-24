Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9294606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=clt428LG;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=d+JAA6un
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C30640AEB;
	Sat, 24 Oct 2026 06:42:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gAmPcmgp1LgL; Sat, 24 Oct 2026 06:42:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DC35140ADB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792824121;
	b=NVlMzoCVG7E+SxK41r2SkoXyh3T8aLs4K14dtyNTTRg29yn4rC2IgBf+LKSh4m3c6725
	 k3bG97p8DQntK9Tsr7AvxrznjoouyHSTQt0cz2ZJm1gJMdB3lyrIolZVvT66Vk5oTC04Q
	 BmHli7rfI66d1b9Cdfsm56Yps4k/zjefDOz8Rko5ikP5rFDgp84CeGTEzr0IKv/T4+RxM
	 Y+yHXPFM2X94vWkNfhwjEE+12NlQ8f+fABOkeomgqv0F4x/S7NadJqR8rgBRqTdqMbvJF
	 I0LHDq3lsLXOaJ0INwyLqCP3QkpEPagglYo3PaJGP2h7SIDl1BOqQrDPid3wOeeuYMg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792824121;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6SW8WU8pTtRuf/JK3yOa2wudC3AhYxhHJpE3BP8ftUY=;
	b=H1h1nOchX4OVp/krV1HlL4AAUUyvs3p3YZ3PI6QaAjVaa0kN4OAfgRsO0YyPozjY+4vf
	 JgyQ1W5mjptw27htKW9cu0XDYfNSDLvoUE3/xCEf8urFBIMrA0kCzGtCoOAmM9Y/fwY2x
	 75wkAks++15WkZKDFtxlFi5nSEccubvd5n7TRKCDsPRCPv2iaA3onQ91+wpJEkR4enC7/
	 Yx37HFcyHh3/0RLrzp+5iBs1MB4+EVhafi+o5LJ8rnJAk15oo5QnPjcp5L7JIQhhxvbPf
	 ADHl6+/98oo+IGwQ0hu80xdZeh2wJYWaMlYNSezxXIaod3UahILDi5N5rPOluzEXbMA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792824121;
	bh=6SW8WU8pTtRuf/JK3yOa2wudC3AhYxhHJpE3BP8ftUY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=clt428LG2QU4HzH76lEKlYxG7QsDuk/rbLaeAf4gD5le8PEjCg6P4mlz9j69IctMq
	 jJ1NMSekY1RvfT9RzFXjUL7avwBCmtQUj5/G7Ioj8/fC44aPQJpa3UuqMMCq1HNkp2
	 hzb14r7pJoDO+k7LX1TBn+MsB9br/ZoMIuiLRtOyWZXwCXvwcQsDNWghNbucSa9/Qc
	 OYCkPILG8vqJyaEeYH3J+4nw+LM8lma2WT1J6etB8O1d/GtbIpn6RuzZbjlnTgFY//
	 XhAUgpHo2adW2CnPVUy//QXT5KRGTd4nspgJTCtuNyrX0Na2IXQ/ZxL1jyQ+W2iA6l
	 TwFKoHT18QokA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC35140ADB;
	Sat, 24 Oct 2026 06:42:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 527C74D1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:41:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 38AC860A78
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:41:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oXrEC7RYOtaV for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:41:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8DC46608FE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792824118;
 b=ixJ/nIhqN5rjAdjwxZst+nHojy/BIc8/UGaPG09uShWjdbn47OSItasPCTWU6s/lJzAv
 bJv/5oKmqE+jEZUBEUKuQujWZm8RdYQeUvv7HhLGzN7afEzxM0PFu+2NpmxH+6oAZTKJ6
 491SMI3qoSdIAYJ2fHiSw8HftLy2dQd3RbOXpodXo6BoaxxDWtthrb4eXclRGSsNxdGUT
 v8ZU0AEhvRluOFhMHjFRtAFpmUmau5TLK85mDHtt0tzmtkrz+V+CuJMPIA3xdXqTcbXIC
 DoIhMZcqQ9qahtB8Ub0SNK3IPhmO+fxLlhz3aASmgltEusrK5Pp2SLPRcvH6xyTJCaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792824118;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=6SW8WU8pTtRuf/JK3yOa2wudC3AhYxhHJpE3BP8ftUY=;
 b=IPr4dB6bHMt5aWspuOmswRHUCNoyhzT2pjcnrsQM+4M5E/T70iJkgRGGEOW/qf/ujCfe
 SvpTcWh3SSLCyix6OBv3axxlbpFUN48AywSJmKY8lXOakdCATxHSSiMoSilqXnNHG9fdX
 l/AFhRYHOmfQMSYtyOP8KG2uWFW4Hnv/yvcIXTngpEMGayJZi40f6v7wK5Yv99lksBjsd
 GwccVoDGVQCk2L90gl3+NxeF3tIfdu96OSk61hwGPG00IxEtHe316aQrv1iPCddD593Si
 qB8VPuYEmKBioI1kN5d4v3ctlJIHqwjvENNMBDfTAvxJ8ZhsMnN6ZUk058ZqLBcukpg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=d+JAA6un; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=d+JAA6un
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DC46608FE
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:41:58 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3ac451e128cso1114649a91.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:41:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792824118; cv=none;
 d=google.com; s=arc-20260327;
 b=icsXtJY9u0nDsV0EQ5Ps/4uaY6neX/fJez3GDRBwRuFnz/bPr6H4bSWG8oMlNbsd7N
 WTx3stwFl9BgVicG52sJ+QJx5MBxqXuXFd2qBwOqaahNW3WMe3uSS7mmg/IIKszWT4yO
 gDiq3hrcx8ndmRziY3LFuMHcv42PeeVlxEboqcLxr5IRfLeBydAtUOBVtDJ9yX6I6gKk
 t15qacu/W4oCgGEEM+jvf8aZNk49pU1L9MEHncPCruVMxQgI5ruZxT+aaYX5Hnf61b91
 DniU5Q621Y5m0iLlvMeBriI/0nasfXO1b4goaKWXTHGY62U2ugnXrfP7mqRJMbnKCWQt
 F2Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=6SW8WU8pTtRuf/JK3yOa2wudC3AhYxhHJpE3BP8ftUY=;
 fh=L/uw9+u71ZiDOqmjlybLnHPNPB0oTVqkdjWVKnRfXQE=;
 b=bUcsqrcLXoEY+e8UOGkL3bjQMx9ONwK7RlfgdZYbFbwLPqhQl64ggsp9/S1Ud9XV5C
 AF92AnwFEvdn4teWZ4yBYt6BiEBKY4Mhw6tOo5CsORnqpnRHya1ZHbG1L39Lh/yLG5xf
 Z/RugDsWxVgOFi50IlqKrbROMdD90XV/4Uo2rQfTkcla5vTUk45aXENCSzSKwSz65ska
 BEkEnTLP5qcfQoGa4R8pOs8yZhEhGLNddulwc7SAiHODCiX2UITkkLT6PLRwz8l7B9+4
 6CJBB/COtBA2fyWhozhZwr9w7HObGKNsUOk+ECvUmQIXdHB4VWQiwh1TBnnND54nmj8e
 vLGw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792824118; x=1793428918;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6SW8WU8pTtRuf/JK3yOa2wudC3AhYxhHJpE3BP8ftUY=;
 b=d+JAA6unQCGgRCMR7eXaQWF80G9Kiu/zZ6xxvQE/nIdnZEintX2k43TU/o4IDXvSvk
 Z0dFHGT4m0IAIvdQSKtu7eNwf09N5Chq23ruVxHa4Dk/E1XdRxpPvDmTihW/PW/aOtzt
 BFGGb5W9ZcGOwFg9m/T/EB6pWzCqburqYmbYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792824118; x=1793428918;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6SW8WU8pTtRuf/JK3yOa2wudC3AhYxhHJpE3BP8ftUY=;
 b=gamO5jxAof/0EvD0fa3n2vyTDYnRnwPQzGm3k9QANlG3DL+TN89JB2vLgpzOszdL88
 aWC5K7lXew07NS4k0SJfk/WDVTcM5cJvnPVAU8ZKKm81Q6flhpvyyWLhQJXrc4tyrZyc
 f5mQW1ofnACYSUmA/uvDMrU+hnokjGCksbQaJn/dKPkYFPy1/MvtCn3aXx1Iw+gklr2o
 UZISuTW3nLttZoAeyXesNhiR13gpDMNhsRD/R6cUiHSKcZo7TyC6+6vsIs1Nuhn4qHZ6
 OWkQCHMSL3d8oLLNz0JyWHaLwIUcSha+Vg+QFv9GH2JGHQSohcr8g226kFH9TfD7rVBd
 LVdQ==
X-Gm-Message-State: AFq9FYKolZjcKC4D+ZpdW70OjXKkYNIFA3hvG3DAE1KNwMa4BaDxv156
 NwK1WIoobzTA+JCKV/rF7REf1c5zQ+0XSKEtFIx5khst9KRMPKiatOEOia3cbwFsxysekpM6LJr
 txjvh0CJQWXUsg6ol8wVQJutRWi/xUdcveYoUeaEpzAfh0J3olOc=
X-Gm-Gg: AYBFou052+GFm/bSKv0cKUsdSsQiDSzcKEzJLQYQCM5loX71+/vXLyBSzh0dpxvFrJA
 LbmaFeVYhAtgQyOQ1U4+mCrHnc3uImWh1nIIVV5opzR43bj1pdhk8qpndLZxadeehfq1pLycgyu
 OkNSqw7R7cB11qjmrlmcOag6xkRF16/tlpehML8bwl8Uev6nECOtD+vuI3YxfiwMUjeo7g++Fmm
 sIX662a/5sGB8NTphbFF1LP+xpVwcdNDuMTUmVvyx8osEuAGoJeNvbdJYBwzmHzZ3xvOtnCmzHu
 yyHZf0P6Kc0kog7FES4+Bwq3/4MRuHsZbmO2TImF37yPK3CzyJ4xeDj5oSXJGYHEdj6Hx9mxcR5
 h+4fqhiDR/fG53tOOYxsYlnyfjjxdLkSAA0Q=
X-Received: by 2002:a17:90b:17c1:b0:3ac:4e18:238c with SMTP id
 98e67ed59e1d1-3adeb130496mr1051483a91.49.1792824117668; Fri, 23 Oct 2026
 23:41:57 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:41:53 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 13:57:57 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261022135740.3869144-5-padmarao.begari@amd.com>
References: <20261022135740.3869144-1-padmarao.begari@amd.com>
 <20261022135740.3869144-5-padmarao.begari@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:41:53 -0700
X-Gm-Features: AclHuK9mWL7S7o0861wxFJzuO8aKWTMy_YxB6mLDLs6LvczvsBOgXo0A4YtIqV4
Message-ID: <CAFLszTjehnebQC4U-Kqa_kg2yrMhT=8bd1RXTJUMspTiUEvvqg@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: xilinx: Enable MTD virtual concat
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-22T13:57:03, Padmarao Begari <padmarao.begari@amd.com> wrote:
> arm64: xilinx: Enable MTD virtual concat
>
> Enable CONFIG_MTD_CONCAT and CONFIG_MTD_VIRT_CONCAT in the ZynqMP,
> Versal, Versal NET and Versal Gen 2 virt defconfigs, so that partitions
> on separate QSPI/OSPI flash devices can be joined into a single MTD
> device, for example to let one filesystem span two flashes.
>
> This has no effect on boards whose device tree does not use the
> "part-concat-next" property.
>
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
>
>  configs/amd_versal2_virt_defconfig       | 2 ++
>  configs/xilinx_versal_net_virt_defconfig | 2 ++
>  configs/xilinx_versal_virt_defconfig     | 2 ++
>  configs/xilinx_zynqmp_virt_defconfig     | 2 ++
>  4 files changed, 8 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
