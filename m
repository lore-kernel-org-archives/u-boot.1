Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23171606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 06:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PVHEKPMH;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dWG4fyl2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D377C8100A;
	Thu, 26 Nov 2026 06:51:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 67MzDhqwAEwc; Thu, 26 Nov 2026 06:51:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E3B5581004
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795675895;
	b=hh086RC3RKa6j/cugI7RiX4Qz0zrn+p5JTiljIOo1fRISkeGQQVYGY3xLJ3N31dbAGed
	 S8GDB+fp7YUP14+rb3CYRuWWx9VbXAe9/bxzibYJDKGJxm1mvDjwPAahnKYPRDQbEJ0+3
	 ZwwRZTnx5UbhDfJt6lr8owg/8PB/UkiR79s+iKSp9H7Hoj772Is3495mDyNZt5YlvoMQk
	 FU3LcpgcxzIuuLtIr9JvKVa4qhhF2dchuVa/II9Y1ToLm2bJN3bM05uv7DoCAMUj2PIdk
	 PoaRS3L0RsjwpeaPgRgZZLbbYxBHf245pwzBhkbjogK61PSaGiP70pJgrM/7JsHU+tA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795675895;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SVTuZlH3lhOvu8Owo4FMGC3nsEsJ3oAx0rkhMvwk03k=;
	b=F27YUKqBQUfIMUhWFKKyY8oH+Hd2xCDMqehaXIcaw5OeD/P0/8px0C4IhTfL0R2/saMc
	 qKAKfGHt2z5SyPTXZIG2PMjG6EE3bFdquFHab42gUxO4FbsKVc6YHohqPao60h4UTnj62
	 TdAQIJDmTmd4Kp3VqIw05ryyenyxg2OWHik2DZUhnrHemTaXWcaPznYsIF5ROFzgO6RtV
	 aQWGnlAMp0kA5nlVlcJR5DCTlA6M8sOdYdpVeYnw6GnD72bPjEZ3cPlI7PDC5j2JhyzaE
	 zK2/FaGOMr4RFdKu/jLoGQPRJpAP9u8w11asjOMV+I+YRLLBJYpZW+S3wy9C2mt8qBg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795675895;
	bh=SVTuZlH3lhOvu8Owo4FMGC3nsEsJ3oAx0rkhMvwk03k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PVHEKPMH0q3zVPoSDGxUm4629zZ83X8IzzRU5TEb6A47i50fluYHY+5GCVzpzgtOS
	 +9y+C7g8oM64Yi88Oe7y5wCrqe32X1g7/m3iGj7Pk1cwzR5z3NncxAljCL7y1lzAME
	 JA05fX/RgyrGjpsqDA2o2rrbeimUSZETTPJznrKtKtqti7sOCpk6yTPsG2Kv+k2TkP
	 +Nev3WJW7vIMOhqaXjpUopKooT6MGdfuCiukBtUYQgDOvbfnleteao6GJETLKO0eH+
	 BTf3xXhG3o+OXbKkflcbyPTpGx6e/OvBjo/qdsD0PMGgyyw4UjfyOQ7sFQF15rKolX
	 pY7oWsEft8VdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3B5581004;
	Thu, 26 Nov 2026 06:51:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 217E022B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 12E0C608AE
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:51:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VT6g2aGFQhCi for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 06:51:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AC554608AB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1130; helo=mail-yw1-x1130.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=dWG4fyl2
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC554608AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:51:31 +0000 (UTC)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8b315dd057bso42296007b3.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 22:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795675891; x=1796280691;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SVTuZlH3lhOvu8Owo4FMGC3nsEsJ3oAx0rkhMvwk03k=;
 b=dWG4fyl2kyhD/+jlabeUumtRSbHN25pdPEA1v1dUfMOtjHcnwh6UM03kIzcXcJB6Pc
 keLUwcrfI9PUwkyFrQlqAivnm/1EDEMIs02AE5rC/5QMX9u8GkTCQLjf9ovG1Zc1aziH
 dB+4vvjd+ATe7y/a6Do0LaqXQGmbzqzO0L/jFT28dBvXfhLi22M0ZiHap26egaZW9nOq
 E0wD7FJCMbS7JsBHtx05INSHTA8rJxT3IBdV6XzIORL1iVI3CaGpScQgRy7WTudFIx9w
 HhZooY1cgFwhhUxXy8F1tC6PLBwz9JqTWSZ8FDgMdue1np2SMslhh8ItXTPVuXUnhFGa
 ZZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795675891; x=1796280691;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SVTuZlH3lhOvu8Owo4FMGC3nsEsJ3oAx0rkhMvwk03k=;
 b=SJy+J3/makDUNUPnCIf5ZrJITv2iGhSI1BX1Q9NTPiao0+ZCt+hfBW06XDYA4Mz7RA
 B9QgXguf9nSRP3+msmVt/+VdkBebQNtu99WSRprVTR2L+9TX6YLilGrXVb6ftfV2Dx0U
 L9zzYlj+joJCTza6eJlfNNnLks2CSfTB2u44SvAImBB8ChxGss2iV1nyQS0riEeUsQkt
 N8AcoHLrBqLwaER7mKGwZcq1N5IcFMR1ieya8ngF225Gm+f9FKtcCvMQ9PLAwoRSzCa0
 4JwpPkQk08hC7swYg15Df8gfrVFeLSFLUTvXjTUnGN0q/nvQAxIdy+DZfgLpVtdMp0R8
 UBlQ==
X-Gm-Message-State: APuU4Z+/8MQrRPq7uy9GU7/BI2wrANBuZzFEPYYhs/jwSyvDh63UTd+D
 CXlAtqOnConb8KHb3ojeRCAknERcEN3Ts8uTFVCeC7jPi4R8YtkLUJ9CYHgMuw3ZvcllWQ0FL+2
 QXPeVZrJZn5PAMTu5G1E4/OBwdCv925djBlwnY2eu3A==
X-Gm-Gg: AZFdTZc9CUcP11gjyNm1GX05h17tNV06J8kTK61FRkyzx6wnEuwF6tW5Ee0ePQUCP7h
 EBhrbBN9OMJNPJPy3Ulzel+JT6WIyV7G18xzXRl270qXXvfpSD2mvK1Ap0FyEtCu7QJH5b54WIQ
 JRmF9IzULMmjVz4oKdFvQzTX+W068lINDpWokuHOXomH8e8tPyeVtbc94qrPsbxgtm8/VC+aYIH
 u8c7TkuaDJfPM1/pd9XJCELETZYWxIRiwN4cseHEwNDSTmItFQLFc6majHGGBJc89DR3OBwGjdV
 P7A3Mk3G6cseAu6I8OAj/29VivhrztS8Cb98HoFqy8W4T7GhNLaRqDD5qikUmIBQFDO2vcLb6Wv
 /hZcC9uSj4LqeI2YIzaZyr77BVd7Bp0FFW20pub5jcfTF5Gbipeyj9LM+vmeymeJ31YkOMheCE9
 fw5X73gh+oXnESXsSytZWR+PbZvlI8UrRaH2UO+cpKMs5bDxRISXCjtlSXFie3XlshGOUFPjEtA
 8foVtpng6JgtgM8SystRv1AnNlqeF7lk5wL3a6m1D6kkt5C+PUwHkJ8uU//ZA3CGVxjEmzFaW/r
 IGiy5lumzIoxR5Tu3FPxKZu2iNaMG8fVyrVwOk7d2jcuakUmzowYPKzVUzckduPAtjvwUgE1KVR
 T4ehBCD0/faIHduhPbRYEnQrbj6Kah2jXoaFlJCYhe6xizaaf/rspeLpONhKRQdN/dIYvDtI2W6
 1keG1q6PqgkV/v8eBcrPbnK2K7B+hNskc8p9mA+VqHowSvsZyZTjH/o7hEAj1E4+B9hWYKn7E=
X-Received: by 2002:a05:690c:891:b0:8b3:7782:6772 with SMTP id
 00721157ae682-8b5204ed76dmr80817017b3.49.1795675890636; Wed, 25 Nov 2026
 22:51:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124211914.3088229-1-dimorinny@google.com>
In-Reply-To: <20261124211914.3088229-1-dimorinny@google.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Nov 2026 08:50:54 +0200
X-Gm-Features: Aa3M54pAZN2DGAgC3AAy0vBJ1ZZJYzREv5MjBnhEHdqwA5k8yH_QaV96PXh9xrs
Message-ID: <CAC_iWjJ88Qm3zWomm40ZQbwhK3Homm4Ye87j-cpbTt-U=LY1vQ@mail.gmail.com>
Subject: Re: [PATCH next 0/2] efi: gbl: Introduce Android GBL protocol
 definitions
To: Dmitrii Merkurev <dimorinny@google.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Ji Luo <ji.luo@nxp.com>, 
 Ram Muthiah <rammuthiah@google.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dmitrii

On Tue, 24 Nov 2026 at 23:19, Dmitrii Merkurev <dimorinny@google.com> wrote:
>
> Android Generic Bootloader (GBL) [1] is a UEFI application from AOSP
> that handles the Android boot flow (A/B slots, AVB and fastboot). It
> runs on top of platform firmware and calls into it for board-specific
> operations via GBL UEFI protocols. EDK2 EmbeddedPkg already carries
> these headers (commit dfaa76349d4a, "EmbeddedPkg: Introduce GBL
> protocols").
>
> This series adds the protocol definitions to U-Boot without
> implementations:
>
> - Patch 1 adds the headers under include/efi_gbl/.
> - Patch 2 registers the GBL GUIDs for 'efidebug dh', '%pUs' and
>   'env print -e', adds a unit test, and adds documentation.
>
> Protocol implementations depend heavily on board and SoC details, so
> this series only introduces the shared definitions. Board-specific or
> common implementations can build on them independently.

I am generally ok pulling these in. Are there a protocol
implementations generic enough to allow us to boot cuttlefish using
GBL?

Thanks
/Ilias
>
> [1] https://source.android.com/docs/core/architecture/bootloader/generic-bootloader
>
> Dmitrii Merkurev (2):
>   efi: gbl: Add Android GBL EFI protocol definitions
>   efi: gbl: Add GBL GUID names and protocol documentation
>
>  MAINTAINERS                          |   7 ++
>  doc/android/index.rst                |   3 +
>  doc/develop/uefi/gbl.rst             |  97 +++++++++++++++
>  doc/develop/uefi/index.rst           |   1 +
>  include/efi_gbl/avb.h                | 172 +++++++++++++++++++++++++++
>  include/efi_gbl/avf.h                |  41 +++++++
>  include/efi_gbl/boot_control.h       | 104 ++++++++++++++++
>  include/efi_gbl/boot_memory.h        |  62 ++++++++++
>  include/efi_gbl/common.h             |  57 +++++++++
>  include/efi_gbl/debug.h              |  44 +++++++
>  include/efi_gbl/fastboot.h           |  88 ++++++++++++++
>  include/efi_gbl/fastboot_transport.h |  56 +++++++++
>  include/efi_gbl/os_configuration.h   | 103 ++++++++++++++++
>  lib/uuid.c                           |  47 ++++++++
>  test/lib/uuid.c                      | 122 +++++++++++++++++++
>  15 files changed, 1004 insertions(+)
>  create mode 100644 doc/develop/uefi/gbl.rst
>  create mode 100644 include/efi_gbl/avb.h
>  create mode 100644 include/efi_gbl/avf.h
>  create mode 100644 include/efi_gbl/boot_control.h
>  create mode 100644 include/efi_gbl/boot_memory.h
>  create mode 100644 include/efi_gbl/common.h
>  create mode 100644 include/efi_gbl/debug.h
>  create mode 100644 include/efi_gbl/fastboot.h
>  create mode 100644 include/efi_gbl/fastboot_transport.h
>  create mode 100644 include/efi_gbl/os_configuration.h
>
>
> base-commit: b7ed8d19d83d08d34b24b15c3dced7fd6c284939
> --
> 2.56.1.831.g720f3f5937-goog
>
