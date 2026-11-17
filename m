Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773B6606A32F
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fNHSxl1T;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=kP1AdFmq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51EDE80D85;
	Tue, 17 Nov 2026 20:03:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j5o8lbpAIWwx; Tue, 17 Nov 2026 20:03:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AADD08119D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794945800;
	b=XM4VLxqL8Ns28hbkPxFTljkv4elAaYhxhR7Mlmf55I3P5bA/jTG5O1/Di4maPf1jcOiR
	 o0uzcEaOR9vI6rjDiWb83BzDka92Iq/ppI3sbEcGRs/9hMXfBLUEODC0VpZ3tGYx16nVU
	 lOH36hxZ2cLHIMjSogN5WChiKt7+qdmkeCLZ4IIV6H7y+MwWYQX5vPxYmXPKL73PKoEUd
	 k7/BTe8JF0T+GvJ6r3B9voI6J0JiN9IHnftLGKA5dWtEEOBpKbElyckIxouVZQBSVrgLd
	 Y9iatUTf5vSfL26yjdzxC/R5gTif7EvuyfT7vQK1yiZ4zpg4eOvdHSQY/vmW2Oko3zQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794945800;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2CzJK1X1IH8ucWUDStkpx6n0B8s3eMZ0hFcT8DJdBI8=;
	b=BqKP41c6obyRaxY1MdQTI0j50+1p6Y1shZpGvQNkl3YV/ZHthSa6SjmcAHlQKnyIhyVU
	 l48e6JZ/DtsOe0l9VGNf68dYlIYyHnRa72ssFxm6P4eZamTMVRsLhjOkAHuW8XfS2iDfs
	 JLWEfCCeYCtshj0c/9wwdi1ZkHzj7w4pA0lIthTEJdJfH2CnInnSyKD2ln2vIqWn96UdA
	 n02htoDYLOrL+eKqs/VsX7Rrs8A2S6qGc6NFH25tSx/IPTxIaNxAVYKFyoP0pEZ41uzE8
	 vyKfNhlbY2ib0i+x55pll7bMvv9gEv5B1zAtRiOwLXNt+kuYVFYZ6BKyr7lOYs9ubUQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=kP1AdFmq;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794945800;
	bh=2CzJK1X1IH8ucWUDStkpx6n0B8s3eMZ0hFcT8DJdBI8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fNHSxl1TmvDM/OoUqiZl4cC2LELageb8C8S+rYrexy3ZFsGC8YpR3dIS/cHEnRjO0
	 pHJk0f+9KJyMdyW5RR3hk+4DuL5FvnjyaCZLF90/E9ExgDWKO3QCvR+vrEIqrCsa3h
	 7kiSDjl2WVV4M+rjbiDdx3sFs5AINe7kcnfO1vYBEowImn9Zg8mUDhX69b1zFoGgAB
	 2TiSwTMbjDnoqX+yeACVKAgkGCovvkhw8FYuOfcDuPl+Tfzlky6rDGtaGCW9bgFFKQ
	 sVGyDvbx1XR37sblpNgNMoXfSXNTRuR5RRsKyI7K2Yd9l/hZI1rc7wBP3Is7c+Vx7K
	 J2AeIDN7yPyRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AADD08119D;
	Tue, 17 Nov 2026 20:03:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A5D71A6
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:03:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7C29D80C9A
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:03:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iW0legc0D2H5 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 20:03:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C217E8085A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=kP1AdFmq
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C217E8085A
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:03:11 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-48e94879f02so100078fac.0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794945790; x=1795550590;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2CzJK1X1IH8ucWUDStkpx6n0B8s3eMZ0hFcT8DJdBI8=;
 b=kP1AdFmqdL80AkrHsSCGfBrzSWA67s9ZyT0oPi1HqK6NIeR97gIEYb4fH9XguW3uZH
 SqD4R3UikQDvch+m/CE/hRa4LZrXxHku4QeWcY2M/yvlV7l+SWdVzfhrkjaXK+woiSVP
 3Ngm0KM3zeLNJ4mAZpQKCN8SnNUwdcU4SdHmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794945790; x=1795550590;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2CzJK1X1IH8ucWUDStkpx6n0B8s3eMZ0hFcT8DJdBI8=;
 b=OvmR7I4p9GKTGu3DHNHFJLyA0hbUFnXyEzdixgweD1XiG6EFvaAbMhWIFnTWoSTE0g
 dbO2s+jRJyo2KQeynC9o5g31tkFFa6rj+iYp7DRuo1neJc+Q/pSpLispYUydReJfHuIj
 UaMBiIFDZHyM/UojtLgblhTmzGnFkDcQGMjPV97gbhEJp5hQVow9YDemDX8wrivvGn+d
 7WUkJnmnZTK6L2zW+GToZQbOQCHPgjzpC/7yt4yiVjfgzFLi3s+F2AAbEQODJjqqb5D4
 vPHiE5P1cKknhronzuhKp/+yWb6KjJrskgWVf/vkoEy1YsIKAqDixeo+u0NnCv00rweB
 G5Tw==
X-Gm-Message-State: APuU4Z9QC1qbeUZ3oYteNWWybG4oPzAaGexEASZtlPkGG0Hx+E59oyVp
 sn2/LcJ3exLBBaoE8ziKRRgHmtyAroyr88QK3Y4BgjCJGOzrgNtTqf88uUgM+zRmFbkXAvkf9xf
 +iuzKWXdjCQ==
X-Gm-Gg: AYBFou0iu/nXwbhywspeEer5rh5RUjX77j0Uz4mt+ALjcy3+71lwkYXsUUwjwWDvhmf
 vp89irOWzSG6DRK5MbB+KDeieDj7l21ktmJfVY+VfWQczCB1FZDZV0wYVPCW6LjIU7KarR8WiJb
 QZr96+WIdsw8jYX4hkJjORe/DqwZtmn+viE4FDbEkOQvnTcQq6kMbrbKQQwLpHcTIpBaRy6X3II
 4zk3rGefXg9smuvtECeWZoPrtt7BlqnbqpY2vOph1wJlo90j1gDgYGT3E5ekbrTQhm46DX9mkZT
 ek0/CyLUKCtehvI5eJFbi8m74MudVaD+3swy6/WRhJukuB9mXYFd4p+SgwFX3/Cmxjota6ugiTv
 IcG+cR1AORPj8/DwtMpgnnNfMMx6J9A4nXBMayOYUPj3VpLRiKOr8emOdJ8CIcVrfj42nInn5uY
 nYBlnqsu810cH9F7O0cE/eyV7Q94DxbsBkWmHXKDXJMTcv5sBxjQIveS/FJPMJ15spzleEk69Zx
 RWuZN0+zUegjqZawpkHf0i/V4HPYJ227Ja3IEyeuTzxaK9AArTF1bb2wKFHbsdOtXM1vMvUzcjw
 RnoEbUbfJbZVTZQ9QROGx9ofZC8HttdZVroaXxskIlyjpxHFexEG4S8dQMTbtfR5ZUbrAB3+H8K
 LSMLsUD1glGFbCd4tUDNtxb6uKPrXlUZLLPS2lttAoBHcLz8wcvveXbAEaarv1E+h+/Y0zqR/j6
 yaZ48bpgCCNuorXtENnBg+s5l1pju+Bg==
X-Received: by 2002:a05:6870:a085:b0:494:9d42:1e26 with SMTP id
 586e51a60fabf-4b76259ab67mr133885fac.54.1794945790075; 
 Tue, 17 Nov 2026 12:03:10 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4b74372cb0esm248119fac.3.2026.11.17.12.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 12:03:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <20261117172749.2114252-1-pbrobinson@gmail.com>
References: <20261117172749.2114252-1-pbrobinson@gmail.com>
Subject: Re: [PATCH v2] disable VBE by default
Message-Id: <179494578937.2846501.5183006102204341524.b4-ty@konsulko.com>
Date: Tue, 17 Nov 2026 14:03:09 -0600
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

On Tue, 17 Nov 2026 17:27:42 +0000, Peter Robinson wrote:

> The VBE protocol needs explicit device support and as
> such isn't particularly useful by itself without that,
> it also adds size and the potential of an attack vector
> so devices that wish to use this protocol should
> explicitly opt in to it like all other large features
> in U-Boot.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] disable VBE by default
      commit: 2f83ef8a7dd4a409b534ea68cd13b17b686cc53c
-- 
Tom


