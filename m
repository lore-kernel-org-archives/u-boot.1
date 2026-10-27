Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AE9606A31F
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oIafj5kC;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ToVHVKl3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C91D480BE2;
	Tue, 27 Oct 2026 13:56:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iOPRnbZdjcml; Tue, 27 Oct 2026 13:56:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E65D380B09
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793109375;
	b=UT1ZDVfEkeg12oo1Ng1ApJHB5l90Tufem2kyZQ4amdhhnEyz0Ne2UEv1mOQI6QI+Iewp
	 hDJX/G+9Kxt1BLfP/Nh/AKWAHIVfwTY+9UgjU0KuknvTS/VaDu+G7f73QN+wv+qU7w5Vj
	 5kRGWVPuOWTccx3bAUw4WOY7oRH7jzqEXqrl4km+dEDTrGgip0QQG3A2ZY/F7FtD8OYcx
	 7C4yu39d7LW+xJguzB99l/8BLLiu6jFxDc9aaS3Gy+ZrWEe33KTCg5cfQiMsNTjQQFBfK
	 ulvFDOEBdPItwseieDSVxDMsV0y2HmEZM2uFSjMbAWPIizb933daqKYX/kqLKf+37wg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793109375;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5XDCVt+L/Lo6NHLERMEl4IKrcOziQZiW7d/JziGTLeI=;
	b=tFvqM9iqKIYpGH+NwuIW2kK2gqz+xLtdwJuCAAGc9eurVMwE3VRQfpYCEmZyBpfhhaEA
	 cDXPyD/tycrrTqXXpMkNfbMprYuKxg9ifG/CtpakWlMPz8T4zx03Vk9qi4/I+7XPGU+Mi
	 mHwUgHEidjGAalU6u3DSNnPUPCj7oSaEZQf4TB7/aqtLEEJEB9PVeQU02JORs1i9EStfU
	 pEiay9lXVWUycLsCkuxlLgOYAsR6fdvypRwRIlWHQ1cEH6hu21mbXFSmKSgaijHO/C0bw
	 nkJgZy/+Wgr1QNTgWS8n6XpcXvbdh2y2qcYJcw/riZup+cdbbd9ZuFH7OJpYHTFjc8Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793109375;
	bh=5XDCVt+L/Lo6NHLERMEl4IKrcOziQZiW7d/JziGTLeI=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oIafj5kCq9YHIuujQU9PujlQ4tIc0UTC/+0ZqS2WHEp1wLkmhqEigVWCubP6Os2VI
	 4bR39aVu5o3NJTZJkpOmVIY8zhDUWPJ4rDnMrvaEemCNb5ErpLeWFwyhFuGxJyvGwf
	 QczBiT11s59m38yhUhdCbrT1qDvLSJPEs4dWFRzqIirGtUjIwWOrofXJqpjK/KBKMQ
	 bh2uItvt9Lw0ABeX1Xdhu1bZ7tw2XTK4/eQCidDF+R/HDFV8ai+LT2DccEG0elL1l9
	 JOyBB6bpURVlVYBP9mjw3IlWFBPbH1C6ex0y+l+y1w1KC1BFQ92ACcKMPbha823WXv
	 hBpfNc1/0F4dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E65D380B09;
	Tue, 27 Oct 2026 13:56:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A194E4BC
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 875A14028C
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:56:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3dMRAjsGTQ-F for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 13:56:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 83FFF4007E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::22f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793109372;
 b=KohXwQz8MuFfr9XAUKK/tDeSo5eJMxRAQCP5RCwna8FxO6pz3rtUROp25huI4qE3iXeo
 98cnKNHc/odtjlHJ/R7WXojivihoaXeGagi6w2+pXdXmb3HYCM/mLgP0/x8glj0LI1mc0
 e6Xf+Kn8FEGNz5YX6GZ/FylbvIZPVY7WDrle9Pc6DZzKXK5nBWkk6MLbrdDU4NdLgiqC/
 7w6LS3zLC1V2PNmDx7i7nPCOTZiStzXXuzrXRIs9Y38W82+G37WArGuE5TZeXk2Ev0Ndt
 MUK+7cBks4GUSkQKcZj6YW72RDZ3EEZ21YFRgBsXOTD2ziDnkBpB5l2c45FofPXAdYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793109372;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=5XDCVt+L/Lo6NHLERMEl4IKrcOziQZiW7d/JziGTLeI=;
 b=pjdMpeNRDBcc6YWoN05RYsFhVLcrtrb2s4ZUKvx2hXJFYCHSL/TdxTUffzGD4SaE76Ap
 SLBwGo2peB761R0Rw64eXFiCu/y2PahWJK7K7yauZIi0D2X+NT5pMJ6SclA5I6YpLPcHL
 AC2yFWf9pIJ/suanWm2KhKbTzq4Y7t/ZO+72fKVDwI4QrT+G8Ah12ZZOp8QARLbSaM67g
 1frdncshE1UNVw8u1/tWgX5aFUbqYnXOdMHQlIRjSmusu/bERMwKmolRBgPFVbEi8leIH
 JUTe/hOxe10vSthVj/O27kaG1QC2TlBol3rMOPq3rx+aq+lSaHb5AGlpZS2FzHS0euQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ToVHVKl3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::22f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22f; helo=mail-oi1-x22f.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ToVHVKl3
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 83FFF4007E
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 13:56:12 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-51f2e9e6987so579625b6e.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 06:56:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793109371; cv=none;
 d=google.com; s=arc-20260327;
 b=Rv5oLwBkycu2+Ia98/AboBc9Aw8DbiMsZt8Eb+jNEDlhEJYxbNiA/YtHorgg/x8hp8
 15cttFeg8nALkEYLgdKP7L2CnE1kFgBMlx5rP+e21/Mk7JQ/XfbVzgKfGNnP42fdxFab
 pgh9fxpstI1m0/f8VPT+arTDO7heoIHGgPtfpdhT/iYzTQoCs16gYlpth9IJO0x73/QM
 OQ6cdSvLH1IX5FDgSoIsvsn5U/ehyXlqcnaMn38/JHOAXu3XUmuqisQG4meke7YiS04V
 MntI9pUb4Nc7o2p+CQV2GLe6R1/NDMcaaSJlob5jVzg7JzcXAzghX8r9iaaiFyjnaj2F
 +/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=5XDCVt+L/Lo6NHLERMEl4IKrcOziQZiW7d/JziGTLeI=;
 fh=hZx9CWzBZ6DdRrzIeC1r6t3a94N9TpgpDybONtibGEs=;
 b=ZE6E5BATLETJMgATviZ69mOEMkFH1Oz+6hKxYfb8gGCMlrbcSkmRxDQxPeWYXqJ+4S
 xDL2W/9CU/4/428V79K+0DAGtImA2sH5XtwFgIJ0JvkClXWZxYyLQF7SeoNcjAW0xP7X
 sawIj//4DStEJwwzwCmJo1l5OrL+Az1F2A+wqBn3w08jG2KeeL385Yz8TsZmRNoBPVXu
 jqC+4QVu4gOr3diBAVZjOA4DdEQF0WadKEzl1j+fGJARd84ZRLRxcfQMm30snD3dmxnL
 xjJU83u5spniPtc3kuufmwpn9h7Fl8PvmX0CoV0pemJi9R1CGnQ5LUcqPZNfgK+8a2r+
 unXA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793109371; x=1793714171;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5XDCVt+L/Lo6NHLERMEl4IKrcOziQZiW7d/JziGTLeI=;
 b=ToVHVKl3nWrP4NFVDPUI5+xU+8if82Ihf2UOThNn9cpaVC03G8h8mhQ4TV5hLeXuLQ
 2q64jsYjCXgZi+ciUNIQPLei20O6V5/HiQugOs/RdtGTK+gxN1f5NGLz7FOnkZrDkzLH
 6iMbm2sB5zyOCHwmHnpbY0XFOkSVwyJkRmTbUeHyakBLjO/Mx2sPhdNu/Nxf8Lk81Rd4
 LWkybbODR7djJ8MReWebD0mQLyoJzhgZ50/hwBGATUlNwUQh8SmUY1NwYvOMgPojOcAq
 lyEEL7yEXWtTvc8ylgkCmkSseO70zZ35bkhDlV3dT+p+Pc3COQZfOLly447J6WYcNkFz
 uMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109371; x=1793714171;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5XDCVt+L/Lo6NHLERMEl4IKrcOziQZiW7d/JziGTLeI=;
 b=NI5ChwvnnD6MW7vL4i1oy3rNgYk7VcsT1fgW/y8jsORhcUPe3N1ot/UK/cTwFymOv8
 Gvx9xek1xIcuiuSHErwsGN+3Q3+Fjp2u1h1Yp7lFkPYNf41mJHAv13G7E3ABlZE2i1Lx
 zF/OF+0Ybrw4UL3dmZxSe5zfOhu3GscXFBG4FcKDJWaq/AGHTrMO7hj0bwQEhxZ8xJ4e
 1NNE6V643EfcLqQ46/594S47pRrkGyg3P9Fvpe1/fAwvbE60gNV9XyDdLfSb+eVKg2YI
 I6C17+NKakF553VZAPyPiKCL6AAyPhxjLdWWk0Fp6Fb8blGMxG+MkPlWH1pYBrhdh9rn
 MggA==
X-Gm-Message-State: AFq9FYKl85pWi917UQHAxqG6T5me0W9Ce327XFaspDO01b62U9iAoVeC
 3zvzV0iIDkRtEccSkRKeY7qGAkOy3jniFPKCJvDapfavusH2HgS8p93PAbI6Rlc5udAZPrlqo0d
 qB7uoMgM4Ysa+i8prAXHRQs++iqK2CQc=
X-Gm-Gg: AYBFou1XC+6QfyCxQadpJbZLT4doKJxt9pA/KyORGdwpDhnefQ2Njxex0JfXfrFUbeG
 ht6biBZ2tUDBSD0GIMrOxahhHP+KlQunaifYvBq4sVDL/R5bM161IUB4OpPjHgPBtxpBppuCkEj
 /Tdc3Q/kmRMv4M94s2XxeuG46f3Y0LIP8ym46es9Qu5Eqq3I//yYiiFdfhWSUNXVEcimx0GzZSd
 Gx5P/0cwBlVgRNElpMhKtWwuh88hU/IgycKBZ6Gp4u1sheg3+734BEo5HUFuAdtEfbzmAhySiiu
 tvTWDEXBuhSONpCs+EJ0syxhFJvnQySXGBT0vjdL7iamv6TGhsDMQk2/yxkAqjlqgJ6Ge1LtUuA
 PMFngJ6xDfLQr4KgWes6egNMwfL3u2AUfoeXh1g==
X-Received: by 2002:a05:6808:1691:b0:55c:844:989f with SMTP id
 5614622812f47-55f7ef3db5amr1495531b6e.23.1793109371007; Tue, 27 Oct 2026
 06:56:11 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 06:56:09 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Oct 2026 06:56:09 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAC_iWjKF3G4b_=LxsD8AHxQt_pm7ZK1E0JantZ__e_EwDDTEhg@mail.gmail.com>
References: <08c6c3f7-4241-40ab-8a60-383b9408b6b3@gmail.com>
 <e7aa5f28-e3b6-4b52-9019-1136d4ef7a82@gmail.com>
 <CAC_iWjKF3G4b_=LxsD8AHxQt_pm7ZK1E0JantZ__e_EwDDTEhg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Tue, 27 Oct 2026 06:56:09 -0700
X-Gm-Features: AclHuK-e8K0QMfnt6zu5VeDRieyYpPhHxAPnvK2A2Q-V8FfOWut9vfBdD9YLcGk
Message-ID: <CAJnxHsipJpSgCXHnefuexiVFEb1CJ_MMHTtyt9eTVBGkzKOFjw@mail.gmail.com>
Subject: Re: [PATCH RESEND 9/9] efi_loader: Check the GPT header before
 measuring it
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

Hi Ilias,

On Tue, 27 Oct 2026 at 14:12, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
> Is this an actual security issue though? IOW the measurements on PCR5
> will be invalid wrt to what remote attestation or secret unsealing
> expects, right?
> I still think we should fix it, but a more accurate commit message would
> help

Yes, the PCR 5 side is the one that matters, and the message should
have led with it. tcg2_measure_gpt_data() measures the primary GPT
without any check, while the partition driver uses the backup GPT
whenever the primary header or entries are not valid. Unused entries
are not measured but are covered by the entry array CRC, so a byte
changed in an unused primary entry leaves PCR 5 at its expected value
while the partitions come from the backup GPT, whatever that holds. I
checked it on sandbox with master: with a backup GPT whose partition has
another GUID and such a primary GPT, PCR 5 is the same as for the
untouched disk. So a disk whose partitions were changed that way still
attests, and unseals, as the original one.

The unchecked sizes are a separate bug: a header whose entry array size
wraps in 32 bits makes the walks read far past the entry buffer, and
sandbox dies in bootefi.

>> Its partition driver restores a primary header that is not
>> valid from the backup, so that the restored header is measured; U-Boot
>> leaves the disk alone, so no GPT event is measured for such a disk.
>
> Shouldn't we do the same thing here before measuring?

Yes. EDK2 also changed its side this summer: since 7c12d4359abd
("SecurityPkg/DxeTpm2MeasureBootLib: Use GptLib parser") it measures the
GPT its partition driver uses, read with the driver's own parser, after
the driver has restored the primary GPT on the disk.

So v2 does the same: a new part_get_gpt_primary() in part_efi.c returns
the GPT as find_valid_gpt() finds it, and when that is the backup, gives
its header as the primary header gpt_repair_headers() makes from it.
efi_tcg2 measures that and no longer reads the disk itself. I did not
want the measurement to write to the disk, so the header is only rebuilt
in memory: a disk whose primary GPT was lost gives the PCR 5 it has
once repaired with "gpt repair". Only when no valid GPT can be read is
no GPT event measured.

The test in v2 checks PCR 5 for a valid GPT, for a primary header whose
sizes wrap (the same PCR 5, through the backup), and for a backup GPT
that differs from a primary one with a changed unused entry (PCR 5
holds the backup GPT).

v2 of the series follows once its CI run is done.

Thanks,
Ana
