Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5C5CA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 13:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CE03811F1;
	Thu,  8 Oct 2026 13:02:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nQ2RFvcMRTan; Thu,  8 Oct 2026 13:02:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3AC9C8107D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791464575;
	b=Wrl4bbV+yjXhaE6T/7QBzhDYvR49Y20oPJUyQ7fD8xWifzlA5SYXA1cTwFRyJ17OtQfH
	 ZgIszWYADJBplfN7+fTPFGqwiZyOJRqSb1pGH1BYyRwa03twqfslcyLzChkJgRhX6xTRO
	 0L0Deo7JH0/6NOWvU8OsGHxLvzy4J9s3yAD22Ij9+0aKqWTw4tVhZbQhAIj1t3DWYbn6G
	 isZotjSoKxrDQI0npyAUQHq1KMSWy6ZspufpC3I2PIYsgnvyh055dPmlhm6rRek4VT/mP
	 B/Kgf36BV98mFtNj26Cu+06AG5eLhv8W7cJTinmVq2KhhUqTpZCY50yHWeD5db7dBZQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791464575;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U3A6zVr5eXbgtbw8f31UnwRdp8VROnBNLSyaMeZxw7Q=;
	b=PDloSrzndrBNKOGbokkhv18FVmP37vVCQ+CK5Bu2wjRD+rVO4m7uD3D3W4popunba5Ih
	 7bu7ajRipncPsjg8qHqXQujeLukFK5hhZL1BvDI5YHdt32ChXFK3FzYab3tAyrOtCnSnx
	 dMlyLWF+BhGmrOOkETcXfR60KT+Rsj0fgAyoQoaS2PbmyxlAvMKhNNK+1jb2NQH8gtIQh
	 0Ad3w4j+Xr4Xu0K5DIXBIg8Ntmgan7iW9YFfEcxeIcxefc06yvI9Vl3aqtwPHV0+J2Rd0
	 7TVW0y/QA2h816sqysRC8o0b+dcSimRCL/S/6gzBa3Dbtpv2idkrsWgEfS2j/ACPQGA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791464575;
	bh=U3A6zVr5eXbgtbw8f31UnwRdp8VROnBNLSyaMeZxw7Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D7kipTJsWLq3q2h0Mfu4K0KDDoYXDg57YLiUvLu6DjuQNPMk9ORem/IKydcjTGuKa
	 onwCyM8inkS4J+dqaQmFTs9R66sWZfMqYXv33oNR2+Qe/QN/sWbfENartkg/JMYLI4
	 Sv99zqGsxaR5VsdC6k1Fsu/uCZL4tnuAKDfTrM2TckWkW6g7aQTz1cL/TzEJU9VMYj
	 wYM/7v4HJ/hU2uewdsqlD6hL5ytqdrugTg8+X7InpVmyxAbpC/QPEOStpOQmi9EyJy
	 zKmg1Gi3AICvP/K/+XnD8zqVbVwe881IGAwIoa29nM9ARR77r2VlsXcbkyJP1CEv6D
	 KYwp5ER9F/bZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AC9C8107D;
	Thu,  8 Oct 2026 13:02:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6539534E
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 13:02:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4AE8760B78
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 13:02:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H5ImOSBM9xJm for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 13:02:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D278B60601
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791464573;
 b=a/Q/VznGGmpVdPDZVJ4+7d2p4+/HAJduUvluWxltHDmaDjuqzuqgPWgDPnO6EvTEXvw5
 AS9pIPy3XJ5qDYQAnPAkHo8SgPoVwpxOO7VR7c0XznhG0HkFG8XcOWqyqUz+vifXXuvmJ
 /Ex66wbUAvj/aD0yrs28B8vCgX/1KOADk5ySr4a9FaYajLxaBkcl9VI6L1cvbTsAWVY++
 8PsxliCFfYmsRTj08oo25rwcFYD7vRrFZHHfnC8zKWrUGcLWO2ySEVR47gbhdMcxOTCL8
 zzop1VJGbQ9Ieck/4QrEkcNzg+0IuvQWA8pTFyw51LD0gCgNQEaMCcHRfLaEvIZgUag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791464573;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=U3A6zVr5eXbgtbw8f31UnwRdp8VROnBNLSyaMeZxw7Q=;
 b=VF51yxdhuo6tcJ52mVGjYLCaskLx+177/Ue8n51crtK7gXhDtnH3jq0KVnF4W+1jJM6M
 bKWgvAGr25RhAIzh4nT+Ap2VwIzGuRLnBz/svv9nVCBAWU4di74b+kNj0yR+1RXnX4+YL
 TDYqi12KX6HSbYUGcvLuu+TdFOrhH+EyguaJY2meCZ6j96pczZXD+qEMUcPCwq+S8AeSN
 ajCtedDLLT3ng9IluOwdTPkL6vN+h4j2E3GoS131RMfTEAGU5Ygw2o2Hc4+5bQh4KtnCf
 qGZWsb/FrRzkqXHIKyCzdz1OnuenqNHBoWTD4DBAh9zVct4Y7dEnqgC60+AByAdROTQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="D/R7PEEE"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=D/R7PEEE
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D278B60601
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 13:02:52 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6af8620a7d2so4303359a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 06:02:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791464570; cv=none;
 d=google.com; s=arc-20260327;
 b=VGH2hOLHgLwueEfugi/WCZ10RFaH1cAsmB8nQuqkXvLekT4bhCoLECnzpH60KI4cer
 OJYJp6oq2jJjWZCu3mzAVFPuomKZprJ/BmuYfc3Hfw2hU1JnQ+Bot1idGBHP4+5+l5qj
 1PMTDMajxmYu9BiaVJcWs0I7WwsIOXt1Ny+B2TlwoLYn77rRlYnCeda9Gv2CcqWfICWO
 MV/sAfGMNxLIE6lX9uDVty9Tr3bcZgzkdLTKvBDB8DVC81fsKsNat1d8T9jifj8UQB2c
 Cx/4wYQMxGuK9gVgG7Um0oFEFY4U3r9Yps68VhWWJhwqSGl/xLEf3W7hiLV0I48ZiZoO
 vaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=U3A6zVr5eXbgtbw8f31UnwRdp8VROnBNLSyaMeZxw7Q=;
 fh=/FYe6fddfbyIIIvrBM133SZUcq0E3l454w7xptmjpQI=;
 b=bMB1jXNBUSlZLsFC5HSD1VXpvAp3Iwxb6fm1h58Eaoq5lMNtTUO8CqJhZ7xozp0ywn
 h/k9IGb54bobsXgd2F9aEXNxJYwxke1v5CS/wQRWhi4Q6CMElVm5oKZhpJ5bTyw7577i
 1TbUi74talX+z6MWplF0jSGmb6KIJ7+P7vZ+NtHWdR682Vgr7ySgmpTpTHjNIWR1i5Hj
 JowUmRUr2Lwq6HEztSoIVpYTtIy4yG/tl8Aoh304DG4pTC3xW4HCLgs6pq7BY5NB/EAA
 kX0xau5NcV9gPSPPfZLRGm3QxCr6Uqkw9CgIx7Ud72w0wrW8zx9mtUu468Rb3ACfwZxM
 69bQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791464570; x=1792069370;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U3A6zVr5eXbgtbw8f31UnwRdp8VROnBNLSyaMeZxw7Q=;
 b=D/R7PEEEpTt46At4i/RsYl1Q/8duEzFOy9P09IyXdX1r/qYp8iuDkpM79tM+ZvwZJc
 ijmTvJLqsjLTILIfVu6hCHlovXmTOk1fyAAw4yySHq9e8/VegBDJu9Rf6ZhOtiqFK5aZ
 SJHPAVOdjMbZ4+lEVbcwI0T5VGF8V0KFFYE8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791464570; x=1792069370;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=U3A6zVr5eXbgtbw8f31UnwRdp8VROnBNLSyaMeZxw7Q=;
 b=S73BX3HcKxP0RYOfIgzXq27gdeNObpynDZhDVV60RqvqVxWRVbG8VxY7K9vc/nBXCI
 9h0uc8OBfSMnfPGNOBOfdGE9KnRppBaLF2kRgXdwdyZE7WTIOSKwzXzjzpIyQrtn8uE9
 9x9/DSIzpUxJ8R0wFq2U2ZsZloGWUlE3G3ZUPZ18g9tF0k9UfvYx/6Ool18cJ+qyg2ih
 6zi3EQBB3U1dgjg6rhc6YOlvIDnaQQZRA/uHw1N1k0yVlkNoTSfEaSpMzuzmhhg1Z9PV
 9/6CtPOkvRjW9Wpfve6pPW8UaS4AFGIZnNU58CyvKWjb/aAyfpMiSDtRoW2Q/zzdvaeI
 42Vg==
X-Gm-Message-State: AFq9FYKIC6Wmb2Xt5Ojq/7VHJx8AgkVZ/M8cp3UXef0Ee98L6vzqa1XQ
 lzQDB6zLk/4ZDq7TVuItFpZyc1OyZXk717HpNW80iE1KnxMlEnRXN+HlecMfo5s2+ROyhhs6zJr
 71r0C4nCSHeiynvOUfzW1JdsWz09wfA9CQaK0Po5z
X-Gm-Gg: AYBFou3vswwNv59hW8Ub2UoA/fORCEIKF7qOZTtdwSDH20nOC2dcAUasx5/O0VoKUPh
 fe7rNSHtiXmuwEJIdOCHXCZlds9RkOE1KBEafXtPCoRmAVvKmnYleupJIXSqgk8FTPuDyqIItDb
 aLCSYCgH4s2Cj/SwWS8+84YokMKaz18fTWtOFZfv5n8xev0sVIqYnVBfkFX4VpWM68cA/4roU3o
 rc6zexsnSMBelskU5qFQaSzeEc6epMXhdszIF8Fw1/b5sN2rgQl7ARV70v5lMeOtcsMn9mdYm4+
 /3GGw0l08nO7wuN+LkxgJWlLYouc06oR4pQZFwKv7MMCwrqEi8uVTJJ2
X-Received: by 2002:a05:6402:460a:b0:6a9:879a:d9e2 with SMTP id
 4fb4d7f45d1cf-6aff375d5c6mr4448633a12.3.1791464570447; Thu, 08 Oct 2026
 06:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20261006090504.110845-1-michael.haener@siemens.com>
 <20261006155217.187050-1-michael.haener@siemens.com>
 <20261006155217.187050-2-michael.haener@siemens.com>
In-Reply-To: <20261006155217.187050-2-michael.haener@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 8 Oct 2026 14:02:36 +0100
X-Gm-Features: AclHuK_ew1IijeTOIzvAupfsHQHKOBVZn_DBuMxHi1v3syjbUjKctB6nk_iZKsk
Message-ID: <CAFLszTicayte=8u1Ktxe7kqJXEKPZq8e37vCsbLN-t5hj8QTTw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] tpm: Add an option to start the TPM during init
To: michael.haener@siemens.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>
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

On 2026-10-06T15:52:14, Michael Haener <michael.haener@siemens.com> wrote:
> tpm: Add an option to start the TPM during init
>
> Add CONFIG_TPM_AUTOSTART, which runs the TPM startup and self-test
> sequence from an EVT_LAST_STAGE_INIT handler. This is the same thing the
> 'tpm autostart' command does, but it does not depend on a boot script or
> on the environment.
>
> Today a TPM is only started automatically when either CONFIG_MEASURED_BOOT
> is used (and then only from bootm) or when booting via EFI with
> CONFIG_EFI_TCG2_PROTOCOL. A plain booti/bootm therefore leaves the chip
> uninitialised and the OS has to start it itself, which Linux reports as
> "A TPM error (256) occurred attempting the self test". Boards have worked
> around this by putting 'tpm autostart' into their environment, see
> board/xilinx/zynqmp/zynqmp_kria.env.
>
> The startup is done from an event rather than in the uclass probe:
> nothing probes the TPM on a plain booti/bootm, and the event runs exactly
> once in U-Boot proper without changing what probing a TPM means for the
> existing callers.
>
> Boards that share one binary between variants with and without a TPM
> fitted can enable this safely: when no TPM device is found the startup is
> skipped silently. Other errors are reported as warnings but do not stop
> the boot. Note that the full self-test adds to the boot time.
>
> Signed-off-by: Michael Haener <michael.haener@siemens.com>
>
> doc/usage/measured_boot.rst | 18 ++++++++++++++++++
>  lib/Kconfig                 | 19 +++++++++++++++++++
>  lib/Makefile                |  1 +
>  lib/tpm_autostart.c         | 37 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 75 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
