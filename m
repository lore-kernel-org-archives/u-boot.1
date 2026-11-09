Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BED606A336
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=s5c44P2f;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=stdrJGxi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9760406D7;
	Mon,  9 Nov 2026 19:28:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1-S3dKngFtTz; Mon,  9 Nov 2026 19:28:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 522654066D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794252530;
	b=rjzEEUiFmoTjYs8FHmLIE7RijD8F+sEHfgIqV0qtuTdLXKhMl5NrqqlWmwwIz0hJOPna
	 lx7u+708Wc1BQQ5Pi7Hs1YZqtq50KqblEVE39D4gKUtJog6NYBP0138VetKWKLxqtheOi
	 RIQir757X0yvupwbyIlYur5tnuhAlMso202bp1tyczJuWrfDBr+WdVSyaHDxx6GCoPyac
	 yM5VJ8PdTCLkNnEXsQPinUW6e4kv6tVjUurnfLKDh1+GoBpnRHDkZ/tek3bOlROtFoOXQ
	 OeeY27DhqTHBaq15e8YpY2UgyFSvVjNxdDtoT53mm4SdgGJINlAh7yKmGP5YIRBiG8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794252530;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PIbGPvEXjekZc4CGRJ6ijdnJr7j4lCBGtru8sZRG5rs=;
	b=b9ylKf3VO0YsxtOlifRMNsFVPAkb3bajNmp3SxtTAz5/RshRN9TeoztEvZV0o3joktBy
	 yaBlszmRj4YSnemH9MyJp29PSRyC6ygf59DXmfpXE/TcBOzeLZ507Yk/uc8fuljTTqCAk
	 22C+pIZGaswu/++oOSbucBJdujPtRQZksnZnPx5mGfYdqPC4RHPBrm+Q94yEtshqhWKKJ
	 O+z39BoLrrekWLLxHc84tOtvPlsP3eDO2ze86kq3QAS0KEFmrzOvajC4XBy1ERg0ix5TP
	 635vc0nQ5K8aPAyYnR6RBAVu2z76G5/ftr7x3IHABHuubQLEQf6pfFLmzufolznjzdg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794252530;
	bh=PIbGPvEXjekZc4CGRJ6ijdnJr7j4lCBGtru8sZRG5rs=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s5c44P2fBwDdTzfg7RiDaJNfJ9iJ/SdCcs1/ySZTxbHlCKtTKthKbZOEv6c4KXQp5
	 wVmOFms+M3BSc4FRjyraocV1P5V8bPpRAc5biIY0qPqIhebM6ytPqLewHq31bNUH/K
	 bUYX4LRc90M1PJd2nhoEqfstJLwtEuspcw3zxSwvoW/ufDScHiF0Sh6BsChLnq7ipR
	 ZFlra7USbgTBPCAZL8ARm47XXeNuuNV2+WilV5zXDgNnCgEw8tAd7ZuQBkLBXw+yGU
	 pvQn5DYjMcqP+MxFsaW7zOMN/50wGVL5i8ZnwJOpVYMeXxLmixIoPCVgNTKK/gfdMq
	 Iq2A3UtDMC3rQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 522654066D;
	Mon,  9 Nov 2026 19:28:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6422F1FC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:28:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A21F402CF
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:28:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sYjbjS_WfmOB for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 19:28:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7E099402C8
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::c2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2f; helo=mail-oo1-xc2f.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=stdrJGxi
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7E099402C8
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:28:46 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-716c0217635so1070078eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 11:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794252526; x=1794857326;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PIbGPvEXjekZc4CGRJ6ijdnJr7j4lCBGtru8sZRG5rs=;
 b=stdrJGxil6BZHId2b1tUPZ8mJR68P3XCPYMebBrmGNvA3EZdnbo0chffTgAaRysJKF
 IkdaBZ3zYXPYW6x4hF0pobKDTofypApGTMXXfTGIag3SrvdvjKIfAi7R59M08mZ6tl2u
 9CUgNDtZUBBLLXvN7fzG6PBJz02K1FSLENbeWMA2tCebuTIia/gYAZoYoG4c5EbZ0ZzP
 jRH/JtQCNSqwZB5hrKL4DGg8T2ZNYZ3vK4bXwEMpUk4FPi2vU3WwcB6NryoGjFlNA0FY
 Hoe8X1ullu113TRGOo9X+wkXDTdJ0YfcHtepl3BaPDffsxqGEvSdc2bulJ5Zteip9Pg+
 pq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794252526; x=1794857326;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PIbGPvEXjekZc4CGRJ6ijdnJr7j4lCBGtru8sZRG5rs=;
 b=pL5yv5VvwFFjs7aH68U7yM/ydDsmnp7TUyGgdHiyeY8zHaqQdUDRpcr90iCY5T5wfj
 oXuLCAvnKfNF1TjhzRsR+NlChPIqdGUI5KT52YPlyKOmGdT6G6xdtTuJKH45tbrqrxlE
 cK9TKiWHjXQrjYXyka4rYjXosXO0mwd5w7z/AbS0tfs4MJq/3s7OuuuAYEiUgmKK9PDm
 woiYxsMEwBgWZewhVJxzk1q45pNk0UpSmoABwYQKrxMgzHTf5/RbvYSlXS0P1T3FBiNZ
 /3SbkiNLWNvQ/83POfXX2zKtPl55Xq06xZJ0fej1vNIrhXLBJh4HSkDEEoXIH/QFxExP
 pAGA==
X-Gm-Message-State: APuU4Z8IvSUgqeT6QwzA5EWdlA3+Jn0CzWOW2rmQh45IM1PSt4dgM7zh
 mpRoA+XyKLyy/cTXoP1RmxB80QTi9/bOR2BPqQ2MtZ1JRIuBkrEMBjZDnNyWwT762bqcomzQje9
 iD7D3NbBUn9nPcpAQhLeLabiREELcmX8=
X-Gm-Gg: AYBFou1Bc8xNFpxQ9AakWqqDiLqGU8xf08LInox9A5fzSrtuItF+Ldh2Ys1uVNtkzQo
 bzqzQ+BgevjU8lQeKEySb5EtMaWosDzkcuRvOsVrZiuOVDfDNHeOSXkmdZiTZinnjm9bVwTVjqK
 iM6/eifr5Y0qVC+FRWexXWmmGE8X+PAfSyiPoq92UusC/GGHcKB+NXr2arFHxH8NL2Ey1ywtD5/
 IPMDeKjTjVtSbQraHsDfBrHOBOljX8TOcC2UF+Z0xCn1G0Tz6APYbUXEMHKx0GvyuQV8fK31nop
 CPkfhIJUfIpqjgDHhaPRZsn8CGUdSLAx2zL68krY24w9LZtQWchXMPd97L7e6TQX+ywHBMVEeg6
 UzY4/7Gd91y+7UCTzPqlUODy8nS5/UQrofP5tuA==
X-Received: by 2002:a05:6820:8118:b0:6f6:1e3a:6e1 with SMTP id
 006d021491bc7-718997a52famr243437eaf.44.1794252525930; Mon, 09 Nov 2026
 11:28:45 -0800 (PST)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Nov 2026 11:28:44 -0800
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <20261109183030.GT3741582@bill-the-cat>
References: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
 <fd719611-e1cd-40dc-b99a-213e066f3c7f@gmail.com>
 <20261109183030.GT3741582@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Mon, 9 Nov 2026 11:28:44 -0800
X-Gm-Features: AclHuK-1EI5GUVhCS7FuJmJEMOWkHja-m1u6YhB-ui3oO2zDJna9uaz1efuc-hE
Message-ID: <CAJnxHsiAd3Y5HVhNYPw7e2kDK_Oyx=Mpi7SkSSx8h4Vx7MDbng@mail.gmail.com>
Subject: Re: [PATCH 05/11] video: rockchip: vop: Tell the display the frame
 buffer size
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On Mon, 9 Nov 2026 at 18:30, Tom Rini <trini@konsulko.com> wrote:
> Just out of patch context, we then use '1 << l2bpp' and should perhaps
> now use our new disp_uc_plat->fb_bpp ?

Yes, it is the same value, and using it there makes it plain that the
VOP and the encoder are set up with the depth the mode was checked
against. In v2 rkvop_enable() and display_enable() will take
disp_uc_plat->fb_bpp; l2bpp is then only used for uc_priv->bpix.

Thanks,
Ana
