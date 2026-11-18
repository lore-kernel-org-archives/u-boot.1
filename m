Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856E3606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iHRZSX+T;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Aqon/6mO
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61049606FF;
	Wed, 18 Nov 2026 21:44:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jSmZBrvspvO8; Wed, 18 Nov 2026 21:44:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 78FDE60AB4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795038261;
	b=oZDSuj+inVLrZNtvY4qaueU7xEkeipIhhpdmi4/jXTVBIbZkGXTFEA3xghBDxT3q1t/h
	 xV9u5pLnIb/to3ZkmJIXmzFnforKEq2OxXf3eBs+tsvwgv3i7hua0IhGm/GMKXS6iTSPk
	 ucS0LwIw/r1MouZqbhZeSIB36QPud0L0Z6n21YMBpX/R20MtwnQmopkIKsb/6ZO6kiqBk
	 uCAXLv9MAp2z5UOegBT3TCTpXcG5T8LgUyzWNaulCda1yGyRzNq3Q32RNW11Liug3yiaA
	 mk+hpr1Xoq9ao520a60wIVZGyfyJtO0z4W1uo8EbaE5kpETkXgIOtUNQrflUP+KnDUQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795038261;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=G7vn/e4DxjhZiY5LO8OpUrUUGcaz+CSZP2LcXjlrafo=;
	b=gG9PRutzHW+k+C0n8pwkMOhsVqS7cntyrqBoNnTpCs6j2sMFkndev7wFgw9aYJ4OFDYZ
	 qtZyCV7jW5TEFbWIqW2fL0KtwfPrhRcb6HY2yMAyl+CApoWLqF5lF/dl3q8r6NONAdajU
	 0s9SrLcHYO/3bbz7gNGs7uBaULt3QaDCJzBliP1uQd3X4NYIlqpuLoKXA410aWJZ531VV
	 dWC1kZVcuSo6ceQkYxnoJjwkr53VYw6s1zZBOxKiEe1Q6xEG/ZuX/jxuGYUqUnG3hBNJT
	 QXAYXoeTtqIVL0rdcdrrtb+nlru0VHcjwuX88k3FJmacOPSAb2pzXszug7h5PIHJfRA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795038261;
	bh=G7vn/e4DxjhZiY5LO8OpUrUUGcaz+CSZP2LcXjlrafo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iHRZSX+TZav9QYIyG8i8YaSd3fKKJpndS/0jonG50mRFnfvfSJbmrYwFQJGGUG5GV
	 K7C+aF3GAGMOxBhdqaChmsrMojAZsDAFHbOJsdtmEwLFH+QJ0160WiLc6LB0S+H6Gp
	 bfmObMSVIZLGIR61I21+ShdwOxPdIMQdoDkuN/ULBlRqUxiPwn6lUqH0xZEXEA8ObG
	 +839ZWKKx0fZ/8rloQoa4Aw7W2xIo3I6XpPpJzJ2lgtwpA3hvtOdfqE5tp5x2/bf6b
	 SiB1Jyac1kyBKN/Y4NF2MxOvhzcPOYBagdhfMcSC316J3wHZMeJ6UlevPlXpVlfiSZ
	 nurni5r+AoRXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78FDE60AB4;
	Wed, 18 Nov 2026 21:44:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 206AD61
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 129A180E25
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:44:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4E8vBFa_yfkG for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 21:44:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2B86A80DE7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Aqon/6mO
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B86A80DE7
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:44:13 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so16806565e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795038252; x=1795643052;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=G7vn/e4DxjhZiY5LO8OpUrUUGcaz+CSZP2LcXjlrafo=;
 b=Aqon/6mO0VFsBtvlHRgt2Js/UOKj5dDLZtGruXiECBX+vSNvjlhCRNoE4uCFskE3Rm
 O5+BmknmSXubhlmjK9le1tl0tUeBRSIMV/UQ0J8aJf/SKbNTWdtgtZe+yA0CJlzux5LV
 8TfZEz5nuMJzrr8GHQ+okxdtul72MluJJrbgxZu5p4bjQ6Qzq044fQkCtbXu+xgBX1Ja
 HgLHmzSF0QP3mgupPoac/VB3ySs1ia1QR/M1oDbUrOLl6VmorP3gXrxErFpU0hAIp3CN
 ewa5yfCUz/5G2b3wSeMetLhNIZJdSbKFMUt0ruKJN0owBGwxktK1DV1BFyTOb+y3bvLC
 JHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795038252; x=1795643052;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G7vn/e4DxjhZiY5LO8OpUrUUGcaz+CSZP2LcXjlrafo=;
 b=p496NdqPDa06Fc2bJRd6OHducqMSCO3h9G77dSkb2UVJplZUiEQYjt2a0fPDFlEyZa
 eDR75I2qWiADE7Kvus9z0NumT0Wid7Vj7W4OM5zWEL9O8bldfBgyieBstepWm4vvWzD4
 Gy8xPqk/FszciYwm1DMAbeIjQ/yol/Pg6K5hWikNhPKeA5Mk76P2A6MdisDh4AsM/JxC
 jFtxTHGHxyJ/v3nE7ZUg5iPRYm4rRqYOR6fCL5avN75nrAdGzyZwJYfg+BYd+npFjGao
 VzriS+g2HCGG/H5WhAShAjRm0sS2JNTS4qIFWYS1cpCQu9iEev4AH+gyCrVUUtxTNCSa
 8MDw==
X-Forwarded-Encrypted: i=1;
 AL+hErEBY3Wlqbj5/LNkWDZ5lF9xWS6gXgXEFtCJKR3LzA90xTbazZAODgB2ewcQ1XGtl9QhDX74A7w=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9PlyYYQhPJtpAOQ73jfm8hgI1J0jHKaNh8HRmFbDsekS8I2+Oe
 Z68XkmfnrwrMJ7KGzw/OOCZm8xWZZ4o31Wc4ZHzLDMN3Q0Q2ppUtnx0Jzf+8uiNs6L4tpEM9Xx0
 qA64F
X-Gm-Gg: AYBFou1E3Cpen8aX2PtJyNejSuzvuP1cIM+XTSjr+MyW5i4DBPyjDSkhjKM0VTRe3il
 qQAmmdYjcllQfWq0/thGDXmTIniuFlR5Frk1Qev+GubFEJaTmyz3fhbddA5nVJ4uegXyaajVQQ1
 mqKhoZW4bsjpBqxv3E4z5edgWs/udjypvWUb7siVM5lMfldaYh2K4OYcF+BvYO4phRzCyaoVmyC
 CG3WMX+AzJZBFxdzr3jXP7RVK+ufYOY5heda6EYReX+W2KhT/DyFQduk/n20itGlWKEAKNg5VRd
 cHSHMotCiwkYa6Sg1HE1eBLRcju1wQDK9xkbk8dcD5O+C6CGupjDkhWSK22Ub17W0+28/c/Z+Fn
 USjfcEmR879xS33ljzJhrScWdEap6Vp1AAcI+46J0QY2OlckDPaH3fFDpEXLP2JefGb+S7VuU+D
 N1pFEq1zEFu++Jb/WI4Qv1aaTgKkQOEPtQWwYnzbLP4dBfkGouO3MT585Y4H1Z9vM86yzkO0CUL
 feyNnscpDf0oYIm2j0cEDCweaX+kBa+flVmu7ZcMXbL0ob1E8c/o+5dqCEqKi5zCX953205sGUl
 qGQh33VA7EpQAjD905AMB25OEI80xvJIzx/jHcJE8DHOU/ofnQ8=
X-Received: by 2002:a05:600c:3b17:b0:4aa:2339:a375 with SMTP id
 5b1f17b1804b1-4bb7da1c636mr76579305e9.13.1795038252042; 
 Wed, 18 Nov 2026 13:44:12 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8450fce4sm700095e9.8.2026.11.18.13.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 13:44:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/5] test: dm: fastboot: test the flashing commands
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261107-upstream-avb_tests_b4-v1-5-9177277458f9@oss.qualcomm.com>
References: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
 <20261107-upstream-avb_tests_b4-v1-5-9177277458f9@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 22:44:05 +0100
Message-Id: <179503824598.2286122.18003477148431746657.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795038249; l=477;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=bCve6XvL4U9zek1gOr5yoRO9ZELIGJlrVHolwTS05dk=;
 b=Uo7eWaF6S78ODgM75t6J+Ao5Z5kIlAdlsYBzzrOt3lIo0p7EEkE8uu1M2rwRb8CV5yMD4lPB6
 qRviDDIhEyAA5CQuk1LWMrfC4jwCbHyeR+sv8h1Y2b3DBTzn2R0IHqZ
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 07 Nov 2026 13:52:53 +0100, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> A locked device must refuse images nobody verified, unlocking needs the
> user's consent given in Android, and every change of the lock state
> must wipe the user's data. Enable FASTBOOT_CMD_FLASHING on sandbox and
> test these rules through the fastboot command handler.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
