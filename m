Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597A5606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HPXlwvbF;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=W3PGKivj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3655F80D5B;
	Thu, 22 Oct 2026 14:19:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QIEIPpkig5jV; Thu, 22 Oct 2026 14:19:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8379281204
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792678780;
	b=UrGAC6cykIwJAezX2Wt3rfdYCMKoSqJiuM053rZegPrzYqDWSiO+JeNK3HlTSGAjIGv2
	 Zv/p+Bg+m5Ma9wByl8C9JisoYjsqt20tiyoDzKId6wPCBFSQ5C2s23dgaJ4jHCjId+l+x
	 DkW9IQuLOpEyQ74dHPEmiadC6JFmexD8cb6xe/lijLrV/AVm6M474Ll8mc7XBNckNgQ7K
	 IMZ9Xp7P8wRUujG4DtR9Ghul2/GMABpuBehwJdm+WXOwai8d5PdXKvNE/kux8Vo7UqMqg
	 nzSznJah+nhfTIjuJDzTxO74JJG7udOhd1holmUMbFVZEQiKsY8G1rE1l6XcPkPo5MA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792678780;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=trUCXX+qTNVEHw9rR0jjRBGpJPF7FekJIiWhEZYdsWc=;
	b=CLLFyUol4q3whT3GbDKUIGHtYhPkKLw7UoHa7XgseE4YMnjtU4ektY/wQWHvtUzGxJEV
	 U93mddnLX2SS5XrOcLe3W+MUZJfcd8Sbxsnrvyn6TRESdjMej2DqX0EdnJnTY4UGnFCV9
	 SAbIHxc5QHfvNcDjcZwi7N03AXO85vMBSdXc3FLiiuwAgL01YHlfzgI0udGIB1Bh0GSuk
	 K0jmE3w25UzQ37WHp7scn490byq3KTa1J4blrmgxqzeY0Xw6ZSwtQOgQ4+lsN59uCBJo7
	 OmNW4Jhv2yUz8ajYuuCwC/yPv7paaSA+qzJhuicCUqMdEVVnhre06r5nQAFJZcPE+UQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792678780;
	bh=trUCXX+qTNVEHw9rR0jjRBGpJPF7FekJIiWhEZYdsWc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HPXlwvbFJ2+lHWwPsLajpxn82OjjryPGKekAaV9fkFH7PqtdyIEip89FG31ebJTLy
	 Zd7E7hYq1pCDPK4yPLzHtAtC1QmtovgeZZErEIPy8oLtq93LUmBrln0Z0po235US1O
	 OBfzCp5mcmvO6KmYnQHE4fxfM0pF/2RNsHCPxeadakJWR0HiKui6N7gueLJwyAjObX
	 FtnfSHiUvDSuoCmleMWDN9doGM3fOUb9nl8UpLWaMPRSWrfiagRxnU90KhOGtNeyUG
	 3cQrqmRmfM9t5VeQmPb3MRtIctMBAq5vNFbrIOWfa+O68S9/C1vPQf+Lel9lRQkVPg
	 Aa9mulBhBuUAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8379281204;
	Thu, 22 Oct 2026 14:19:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8806F95C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F00140076
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Jm1mz5Ka3jb for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 14:19:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AA8FA40024
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792678766;
 b=YSqRftcI2ECxqjbODRhE/YvwhKGta8lKldr4cku4F9giw6c3ub5++wS2m+raXpUWOlmN
 uyxiagIwPnGNhAB7uP0Y5XfSCHCUGO8EMwUFu4ldQCTfCEYWTZ7k9rBjnLdY85qsfzQxl
 P3qqYBbZkZzy4JRdCNX6e0iM7789XftUGA1FEufWzrfQTR/szvKElcorynu+amrhrlruA
 Uy8qEW1RbYZV5KNb7ekJY0lhxtSW3Ra+jSDW+g0iWx+bEV5EhNrZnnd7F9JcCo4nWH8LA
 10vjkkZzJpNSBj8WrbGWV/RH3MzBJTontegzkkOKaKVPpB6ZpjWBujRZ2CP9Us1zFqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792678766;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=trUCXX+qTNVEHw9rR0jjRBGpJPF7FekJIiWhEZYdsWc=;
 b=qakcsPyuWWJ0s2dAFYsbW8Yh9Fs3e6J7IneOdh9+SGKIeck2gARt2Wp51jEFt7pACsXt
 qiWgwb7pkXCefus6eNXph12Hxkokf9ToWOnmWkJABLQAjXvb7I8xbOPb0WOuRtxBmbN9Q
 s3b2wut2rp3Sz1jif65iRN1fMXBI/DBRWDdMAMM8sV+gNgmFBCLTxKd6vaaLlZ1ORGUhD
 w4yzf780ma5420SNej5oDOs6gpdTY5Jz+MfEEEBj4OUS2J08MtNSdKXPrJSxlHtoVFnNT
 Amhk13W7GopBIh22wiymHlT1LVZCawdJohH3e7orP5t+um5h/6268MzPE2yZK7p0TlQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=W3PGKivj; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=W3PGKivj
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA8FA40024
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:19:26 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6cfed5dd083so1120081eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792678765; x=1793283565;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=trUCXX+qTNVEHw9rR0jjRBGpJPF7FekJIiWhEZYdsWc=;
 b=W3PGKivjJgTxR67ksZWkdlsfbb8+NKTX+/LXHt2V6ERrs7jdq9Dfn5dEfxuEKFLtlT
 orGKIqHzo7aBc0gbMO+TkPVSECIqq82Ut/IYTwebfE133vovmw9jEos87Ny/MXDbZaCJ
 g51xsCe3NKdtT91JHu71xxQlfdOVF22I8h+d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792678765; x=1793283565;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=trUCXX+qTNVEHw9rR0jjRBGpJPF7FekJIiWhEZYdsWc=;
 b=OWRLA+4Z/hAKvSapK64ss126NddDq16uvhHOqiJ9cG5wCnfSgpabx1gBTDq9e5/YPM
 i6ZhXxcwzpnBJmgglzO6ayg6Vj/1PEFskLUMocqPIsSwvs0ImNppGCRWvyjzX3+M5TJG
 38Lpv2N6XSdjc3H0STxaAxL4VA2ds1EQbX+6mn7pfBxtXqQbaTYWgj68ofj2TkpYmEIH
 qAIcfkKk71fMbeeLTrxZg53xisc7ihQ+LORT4HN6Kh7OvpmQ2wAO+HXhf9/g1hdnTA2d
 MtG8W7U/luzZnMrQDAc7iLoN1ro46upvfAux1FbWjz2USiBAtwvuxSxfxJv2mrBkmlMM
 jPnQ==
X-Gm-Message-State: AFq9FYK6sJC+Ux1FRFfExPiYRFVg+9AqD9AF4ypslB30O+uWZl3Fx8i7
 KnXIJ7o4aPzAUDXN3oG38cSv99iq7k3qich+sjJar4m/H7QXRHBcDBlrc4Oe24ayeZM=
X-Gm-Gg: AYBFou0n95lqmC3dCEgp5c13NZ43JB2/A+hPdh5t2zp67MLugxO6EAUx84eLBnuReO0
 RHHO/bncn8GNAg9iQcb7gWK3nvxgS7Y3IMVMMI5MarBf/A1u2WsrX1HKNxfKyfBj5vEfDgPXGjY
 r2TjUf0/zvmUsplHWHXX70YsP9v3YHsTxAk1Xejw2m0zon/l1OGx31GZKuWqT6PxGUSbdbfGKCW
 o0Wt5Pf56jlwH9p2H/QUkwAFSVz+yngWiry0RmZkyV9Wdxy2YN2v3yuFfHsNswG23AUkPe/svWk
 950XROJJ3K1gdR+lmTKd5Iu7QC0Ehv7hBvlcwF8V9U9m6RCnguT7wFZzENreCRi7eec7St6tkbM
 XvQiWLEUOk6FkJ+O6Oh5TQSOOgRtPjJkkUAuS9NEOccwxcorR1b+7GJ2kOQEK3nuge7VWOCsQrW
 xajeeKgtXg2UmsFAalSRGaNf4Cf5N4J2ysM2d/DW9WyhqIdZeJ6zFZ20FmDc5lcHjy3G2s16SNN
 cQY44XQoI7n9C5VPXQWRJo/cgsiVnzZ/x8Khx80sdV0HgUEGsfCgPDskeoiXsqFKuL5Iq3iHofc
 WhTzeT1uWgPq7W4cd3fHjPUmPklSE4gT/ahKsjeYeJChgRbPyDE7048yxd9MDkhWApT693Cc95M
 =
X-Received: by 2002:a05:6820:2909:b0:6de:f331:cced with SMTP id
 006d021491bc7-7093ffbff6bmr3389363eaf.15.1792678765011; 
 Thu, 22 Oct 2026 07:19:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbd2d2a76sm5506744a34.18.2026.10.22.07.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 07:19:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, git@amd.com, 
 Michal Simek <michal.simek@amd.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
In-Reply-To: <7bef6b59da20d997f3ce70b6a8054bc25f15fd29.1789040925.git.michal.simek@amd.com>
References: <7bef6b59da20d997f3ce70b6a8054bc25f15fd29.1789040925.git.michal.simek@amd.com>
Subject: Re: [PATCH] video: console: Handle ESC[0K erase-to-end-of-line
Message-Id: <179267876438.3588521.13782394045442772028.b4-ty@konsulko.com>
Date: Thu, 22 Oct 2026 08:19:24 -0600
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 10 Sep 2026 13:48:47 +0200, Michal Simek wrote:

> The vidconsole ANSI 'K' (Erase in Line) handler only implemented the
> [2K variant (clear entire line). A bare ESC[K, i.e. mode 0, means
> "clear from the cursor to the end of the line" and was silently
> ignored.
> 
> Code that relies on it therefore left stale characters on screen. For
> example the autoboot countdown redraws its line with a carriage return
> and trailing ESC[K:
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] video: console: Handle ESC[0K erase-to-end-of-line
      commit: 32eb8bb43b338cbde7ec51190e335e30f6455bab
-- 
Tom


