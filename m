Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815C1C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 12:32:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 079B68210F;
	Tue, 29 Apr 2025 14:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U8o31vUP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70ABF82145; Tue, 29 Apr 2025 14:32:27 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 776918210D
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 14:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6379661567;
 Tue, 29 Apr 2025 12:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DDEC4CEE3;
 Tue, 29 Apr 2025 12:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745929944;
 bh=8oijkBdwh1D5lPoQYCisHst9S5GLC46iYJ8Ekew4HdQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=U8o31vUPo6XdRsBA6A41JKW7rPYuX2xoZAErOFkf+x8fcspt38UVBYIwDtQ465KjZ
 3yN7lCxLUpJILygJDPfRsxDtqajR0vLVaKtGdpg00MpxUCwEhaCX7TzQrPJx+IhtqR
 XKmCvRlk65dLazwdd0wergUonalv2IAzUmgAnD90WwvMgEUSmw7iHxeWgyArsa2QdQ
 uqla3qH9pyw6h2KKfG401/9bdXS/MqEJjVtddxuh1pUJNi1btWMDWOqekY9ntoZmgc
 9IoDoI/VDb3y4OT1si5yxH8nSatq2kgUGq5gR+d6Q1VYh6bCm9o7I/BuEphzCICfp3
 P6mzxa4p0rrqA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Dmitrii Merkurev <dimorinny@google.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: neil.armstrong@linaro.org, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH RFT v2 1/3] fastboot: blk: introduce fastboot block
 flashing support
In-Reply-To: <CAOWkq4kKyFjfeQviK+3rtEppeqNdmMg6uvHNXApN8zFQUuLU5w@mail.gmail.com>
References: <20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org>
 <20250409-topic-fastboot-blk-v2-1-c676f21d414f@linaro.org>
 <877c3cgwsf.fsf@kernel.org>
 <359a5f7c-4c65-4813-be8e-97e12c7786ae@linaro.org>
 <87zffzwfz9.fsf@kernel.org>
 <CAOWkq4kKyFjfeQviK+3rtEppeqNdmMg6uvHNXApN8zFQUuLU5w@mail.gmail.com>
Date: Tue, 29 Apr 2025 14:32:21 +0200
Message-ID: <87ldrj5esq.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On mar., avril 29, 2025 at 11:45, Dmitrii Merkurev <dimorinny@google.com> wrote:

>>
>> Dmitrii, are you okay to re-licence this code under GPL v2 (which is
>> common licence for this project)
>>
>
> Yes, I'm ok with that.

Fantastic, thanks a lot for answering so quickly!
