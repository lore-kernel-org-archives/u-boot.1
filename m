Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618E0606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ETtxVzqi;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gzz9vGBe
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F47D606D6;
	Fri, 23 Oct 2026 13:30:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dUa6NREoFTjw; Fri, 23 Oct 2026 13:30:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 739956071A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792762231;
	b=VwOR0vqmWl134kLWRkfd3WTYKUWoDubD9rWGhKU6QfJud/uUJ3kHfwZaXv9AAaUE/H2T
	 Bh28wxfdkQgRdejQoY7XsGhVBOiG8tl3G2GMGzOUK0xHusuf0qQBaFPNGCoSHCxZcjorm
	 5DJJQqqpdoQs7P54lkE18ui2uAv6tO/bII8vSdt+dDYPnG/TcUjDR0dm7eROs4TrhrhlQ
	 /49N56UFxx0JftTKpuqLNJKHOkKJyqXfqfF6BTIvR/6sYzGgZq3P19yiRPInmL8mo5/fU
	 GPFVHaDMsaHkpZSUXIq2RHnB4iNfQXTPB55ojnqMyX0iL3dKs7H8tLwBvrTeSDn///A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792762231;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=V8aXeyBJnOpvyz8TCyMSSZUMmOAXJvlOpgr11ue+nSM=;
	b=q1Y2PlHonpYck18iYMZcymWwAsjlO4Ys3QhOLioOloYMnsmTQAIFN53yxW+50BCcVIgt
	 Lvi91EIloO31rmrRGRAXrjQxZQ98ii/NvrwZ8OqaMPA9QOtwFGQGausR7cvT5ZgIexFKQ
	 7m0TQcEfhr7YReNy/ZoX2HZWIK/F7mDb0/5Jk3WCKMYPLvth+7dqYNY9FDi0roZHiF7ye
	 0VXWuKHxXMlvNF1Awsc+a+qVv8JWyNWB+KVIllK+5rJGu9OjtyRsQTAlynRG3Lg1kFaS7
	 m3y89Y78V3+HvNrurMaMf70/V7UZeIJqGMMH3bM83PirCN/WN/UGeglAe4JvDe0+KkQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792762231;
	bh=V8aXeyBJnOpvyz8TCyMSSZUMmOAXJvlOpgr11ue+nSM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ETtxVzqiW3eHtWR80paAh/UDIhLbfJSaUhl49d0QJFNLpjyvUDSIIsbrK5r9bGb2p
	 nTWC1Xs4h+g1bWpO6zMm2mtXhwkpP3COav4VP0T5S2sS++5I3OYlHZz/JALwlfHOLf
	 39e0YHRaidyuQSF9B2sLgWbmumLyTYevIak7AeDuXETxqVCAH5yzGbjcUJWWrSAwAT
	 ljisCPzrz1qjFU2zj/vQZBNzF7XrQ/Bsci68++Pefw6updWITCPe2E8MFXPlZ60gJY
	 cXtMpJ9gsfc7IZjjAQ58OiueT4ReL2z9rV+5xHVrpYdlwU9Ft5CvXV5aU8mrFN2gil
	 Dvgww3vmb+H3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 739956071A;
	Fri, 23 Oct 2026 13:30:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 234C0356
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:30:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 08DA1401CE
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:30:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 822Qw4cGXJIO for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 13:30:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5C45B401CC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792762225;
 b=ixTbAqVLUIGLda5ah0RZSEBwkFzQYbViKIoYHg3EVTMVKeYnJ6mXke5aIfyco+7p0MFr
 LWN4C6WZByxVXJ8E4Od9Hy5q8HzYEG/us79XrFDwQCEpeeRFcO37wUsnwA6Zkb6G61S1w
 FkCbPxobtmNRlnrMfp4R+h37B7IBsqnwGhQLzy9pwU45be9LkbMULjsWMymu8l7UftQg3
 sm6yiIhDUmE4Cnn3SsePPt/RlYSJev8w6RsL87suqtA9Yko1Nx5Myqn4PT7lzMhYiF/fZ
 vrUt9J1tPVb8ftJK0+L1lOUIz5jIHZREyFRcFKZrOHoAjrTE3hPzZw7L5KCMWIeFb+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792762225;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=V8aXeyBJnOpvyz8TCyMSSZUMmOAXJvlOpgr11ue+nSM=;
 b=thUSUn6z/5knQ7+s/0wJedjbPw+URpX+cwx5Km0TQuOKsXMrOYVO75Iq3DqvtrwQlJgg
 nx/8K/7ByoOgoupBPeT6FpEOt/CIQBLhY6Iz6qE2YbwsGXnK3CumgjDarQVJ4dOMEYF1O
 R968Iw1AWCTIqdWUxY79ImHCoFIvstUKK3Yx24dSZvNS+qkFloyb6KIrQMQYnH+ipSGyw
 VRfcvye5jjv51Hr2rCOAo8ApUXgHInQ/efOBmwPOnXTDHs2wSdmiBeSzAzUNjyNQFMmPj
 NTmyBxaANLECD6AlfvZAHUydvgOEDCZxY3pKFjVbyxdCep4QX7H8mxC4M/obqpdtM1A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gzz9vGBe; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=gzz9vGBe
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5C45B401CC
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:30:24 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-8256106635eso432740a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792762223; x=1793367023;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V8aXeyBJnOpvyz8TCyMSSZUMmOAXJvlOpgr11ue+nSM=;
 b=gzz9vGBeQ5zlIGkOr1+gJAYhVy6QXLDa8U6/fMtCodFKT0NEPDhwib8OmnKCrbh3SC
 cas3FEqJfDR3o+wyrLB3LWrn3/JaNtNDMAYKNqApzvPrEi5zDzq2SRwA46drTk27koDp
 zuD2X1B9BuUAw8dyesoynzH1Hl4Ls0USbSr6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792762223; x=1793367023;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V8aXeyBJnOpvyz8TCyMSSZUMmOAXJvlOpgr11ue+nSM=;
 b=BsMou52+MD/j/L8PmZkuv2kdU44pp1kzjkFBKPdfn/fpCQMFKr3QSh7en+1cNglKLd
 tk/4HGyj1TN+E0x3vwgcA2lNL9vvgOhZy0GpMWGl8aIlbU0q+aHgC0ZVtnn2FLU3tRg3
 Sxhtwra/UqWwx3Bm/64tDv2Xi4yDGuosLpXrEN3zT6qPfTo9AllN5M/QdExrKZS4bcB2
 Pc2S0Scz1PdPA6b7tQjE2y0IOWG0pt3er3aV0quHuaO50ILe8qUATTysp0Ej+nZfcBTP
 +W+3JDw+74nQBAQapBVRpwkFKvn/JAdwZih4XNfHgxXa9KWUtj4Vm0CnUA9GaSDM2/Cr
 Ok9Q==
X-Gm-Message-State: AFq9FYI7SOtxOaPuILavS6ijiRQ75nIktKF0YoDD3SP9nfgEdnb0hfDt
 ZvtIbdfrK3Oq5OC1vxF8nflOWckCUfiIZzpKASMDIXd3YLDGtdrTxbt1HnWxTvOzrJE=
X-Gm-Gg: AYBFou30hCv+OoTezixJdMWKhfZ7QUYiyRLj6yd6t9EQNs3BDMVwC0uQ2S6A9JZqUz0
 ukdJ04gDP4u7/PkbMiKaiXwXXkfl/EC3fVulJsVf53l7UmUM2reG+OQk2mvmNUxXnhFu2/m2m5G
 /b8GbmAViI0tL7FaSIEw7MHsxGXp/Jmhi80LiUeprKh8FSFDE/31PpV3YkTULVidcLwwxte8pWf
 e0vxkyhAcfk+Uo40csWIgNOAzhf17p7BQvVOjsfI1dxcVeIz5+lXFwgOfe7J4qDg9pikOq8sHJq
 xZ9X5HCnJ7ENIx7f1CIEGuQx8l/NT5csgUzM0XBkq77TrtSxTsgzdgyqjQdAA7gCwF+ciUKMxfZ
 ixrgh4pHlVJuYtUsUc3asI4jLIZSipfAWAO272kHnBrhZf+FXFiiQtQsscvdst+aH3XUs7caQ43
 e2Lsc0BTq17wrdeFaq7MTNFKgg+baZnqGRpc5FGXjzAfgEm8S5U/3rV2udWfvIEpf0kPXGWQhr/
 IuZiJ55SDmUnb+c/x16ALtCDEa1pPEm0ZJCrQc8a8Q+AE7XUPa7MqiSDFLU8/LSR67X3Ba4FgCp
 sHwZWmL2sQG/2NPLcWijm2ilr3Wc2s2ef7Qt1t34qee9KhznOV/mGEMwKc6reStD4xfIhz55jhI
 =
X-Received: by 2002:a05:6830:2303:b0:7f4:eaa0:1d14 with SMTP id
 46e09a7af769-84fb0852437mr1549617a34.9.1792762223619; 
 Fri, 23 Oct 2026 06:30:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84fbdf59d82sm2183155a34.15.2026.10.23.06.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 06:30:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: JJLIU0@nuvoton.com, Jim Liu <jim.t90615@gmail.com>
Cc: u-boot@lists.u-boot-project.org, u-boot@lists.u-boot-project.org
In-Reply-To: <20261013080154.1942483-1-JJLIU0@nuvoton.com>
References: <20261013080154.1942483-1-JJLIU0@nuvoton.com>
Subject: Re: [PATCH v3 0/6] arm: npcm8xx: fixes and updates for Arbel
 NPCM845 EVB
Message-Id: <179276222300.3884908.6723560919820262647.b4-ty@konsulko.com>
Date: Fri, 23 Oct 2026 07:30:23 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 13 Oct 2026 16:01:48 +0800, Jim Liu wrote:

> This series collects a set of fixes and configuration updates for the
> Nuvoton NPCM845 (Arbel) SoC and its evaluation board.
> 
>  - Report the correct DRAM size when a 4GB module is used with ECC
>    enabled, where part of the memory is consumed by ECC data.
> 
>  - Drop the system counter setup from U-Boot. On NPCM845 those
>    registers may be marked secure and reject the access; BL31 is
>    already responsible for programming them.
> 
> [...]

Applied to u-boot/main, thanks!

[1/6] board: nuvoton: arbel: fix incorrect ram size
      commit: 84aa3327ac4b47547e1bd87b357d2e59d47d827b
[2/6] npcm8xx: remove system timer configuration
      commit: 6387c130faa7a9c55aec5c7bc19bc423e8abb6e1
[3/6] board: nuvoton: arbel: Configure GFX interface
      commit: 929202f3775b33ffded7edd450daa5da8834751a
[4/6] configs: arbel_evb: enable additional commands and drivers
      commit: c53e9151ffcf4b35b32f903c0d326e64a0c7207c
[5/6] configs: arbel: add network timeout and watchdog stop env settings
      commit: 050c6fe2c51447f2744e355328d22ca2f085f8d0
[6/6] ARM: dts: NPCM: modify ethernet delay time
      commit: 514f135bb77ea5591798b0e8666c3b92cf90fdf7
-- 
Tom


