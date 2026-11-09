Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1E0606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 22:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AW58LfwS;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=VNDUQX/4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 407844046D;
	Mon,  9 Nov 2026 22:36:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6nIT9s8XzxPk; Mon,  9 Nov 2026 22:36:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1372D404DE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794263773;
	b=LuYCqp8xg3nlQ4tXi8gpgYFkOMFTpDjxJwj0nxZx78eFXW5CgRrpQXG4QuOlWKfn1EUm
	 A6oTOwz8Q83oqXtqDZqualf7DhCu/6Y3yUDeBjhICcZrL4qNBpSZcpkG/sD28zA61v8PW
	 pkBwcILCwS5AYW8GsPiommrVPE+VGd3l+cLnv1/jIf6LxYuyoMj8toivaXR08PDdR3obx
	 WgR2yracKUkEOv8ucUNOxRCJ5jNRfTHltEcBr8vz4TvuiC744gF5n/XeP6rnpt9Gq9Eal
	 bqXnZIKIuVGqkRzPWEpbAKzTcI/m8Oiken7CAYgAfNrNTyX8Z2mFDLezvVdgDcHhVNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794263773;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:
	 X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QMdzbtadsF4ozUr29WN9KVnVKLYZIsl8a/7BWPJMups=;
	b=JanpuSl0zw3XWXxDQtfzTItos9b5sPgf1NUKzX1YUyxFLxzzOnJM0nCWtuLVzth3qi6q
	 T9JmvXbthx54obmI5mmk6xz+Cb1xqJ7nxVEPRQVqP9O/mF4NOR2UMSDOPuuED/kyU7MrB
	 S0HeGEN+VPP1Ws3/rLMz+J57oKxUT9sX0YX9qYHEVNgxol5VVOveAH/HWGM0huVnvBM4/
	 nIeRndoPZAIayP+SiwJzMlTUYHfXnApXsAhcQ+OzqxaYLkki8RZdjjDt1x76zsvAXL1Ng
	 REZtmVxLX8TMlMq0ZUL/I8rq/31Rm2BqnryJWWhFGd75tV/gznxMw+vInQiHFTYFYmg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b="VNDUQX/4";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794263773;
	bh=QMdzbtadsF4ozUr29WN9KVnVKLYZIsl8a/7BWPJMups=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AW58LfwSFtTh/4crDAQhDoplkDushWALsaKmLVYRJXAZvU+iDbU6idZthJSb1HRjN
	 0HiSw8llQPZ2yCozv5qwIg1ojCwdeRLHWM+QjGc7ObradZLDLluS2FM90uRXf0AVZo
	 N2oWe/kooVxM4uCniGRlARSF4zmnqFbs5ZDVmJOCutBvbpUSdfYoAxue5pKi49U0X7
	 e7jWQitGPNnZUbHTjD884pFtJMYQsKyJaUXn6KmY08xtzJbcj+Dk+z27m+boyhNYF3
	 luCMyKb95KOVTTVCa8YJkjg+hRCr0e2+xulvYxmK1oUOiE6Lmz2JGG3soj8UMaEwQJ
	 IyMyQxLfJE3oQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1372D404DE;
	Mon,  9 Nov 2026 22:36:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D2840235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 22:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B27344077F
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 22:23:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4I4qaI5sIngi for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 22:23:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D78A7406FC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:41d0:1004:224b::93"
X-Greylist: delayed 64 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 09 Nov 2026 22:23:34 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=packett.cool
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256
 header.s=key1 header.b=VNDUQX/4
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:1004:224b::93; helo=mta0.migadu.com;
 envelope-from=val@packett.cool; receiver=<UNKNOWN> 
Received: from mta0.migadu.com (out-147.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D78A7406FC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 22:23:33 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=rczQtsYts3pjl/8nzogZuR60zQuMoQgfsfa5nYetvj0=; 
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794263011; v=1; x=1794867811;
 b=VNDUQX/4d1eUjrzLTr5Ex1DPLE+M8y6eUuIK+BheNKK4hzBp35Xy/FSpLUYoyuTohY3ZfeCg
 PfmWoo3I+HpSfDMT6qchJMa0pKE4tEvc7w1If/Xuexde4DcIzW5j/ipiQFkBGqSxh2LUOnRoPr3
 Spt9KOWWg+qq/KN6m0kJjVk2AjbCbUZp/9dugRZmQ7j5XWoTvjnrzPpja995609O9kZ0v0m78OT
 tvIdhJdSjjuJr+oiKkUC1RR75Sg30e8ePx1Y9r+zRVwRC4Uiz4JDgUlRkUpp2Ay1QmmO3RhryyE
 3Bb0VCdKwz75up87iStFSMvPKpGIG83sHbV1wQFHIMtyg==
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by smtp.migadu.com with ESMTPS id 4f7474c5a8db5ab2;
 Mon, 09 Nov 2026 22:22:26 +0000
X-Mizu-Trace-ID: 4f7474c5a8db5ab2
X-Migadu-Flow: FLOW_OUT
Message-ID: <1c237776-9839-4888-9464-acbb5c29034c@packett.cool>
Date: Mon, 9 Nov 2026 19:22:23 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: qualcomm: add Moto G10 configuration and boot
 instructions
To: Michael McAllister <me@michaelmcallister.org>,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
References: <179415866631.52076.3385909914110437826.uboot-capri@michaelmcallister.org>
Content-Language: en-US
From: Val Packett <val@packett.cool>
In-Reply-To: <179415866631.52076.3385909914110437826.uboot-capri@michaelmcallister.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 22:36:12 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 11/8/26 2:24 PM, Michael McAllister wrote:
> [..]
> +Motorola Moto G10 (capri)

These exact instructions would apply to a huge number of phones, not 
just that exact one.

Even the Bengal/Kamorta motos, there are 8 models: 
https://github.com/moto-sm6115/kernel_devicetree

But the same applies to other SoCs too, it's more defined by which 
Android version the device shipped with.

> +^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The SM4250-based Moto G10 uses ``qcom_defconfig`` with the
> +``motorola-capri.config`` and ``qcom-phone.config`` fragments::
> +
> +    make CROSS_COMPILE=aarch64-linux-gnu- O=.output \
> +        qcom_defconfig qcom-phone.config motorola-capri.config
> +    make CROSS_COMPILE=aarch64-linux-gnu- O=.output -j$(nproc)
> +
> +With an unlocked stock bootloader, package ``u-boot.bin`` (including its
> +board DTB) in an Android boot image with header version 3. Pad the payload
> +to the memory footprint in its ARM64 image header before packaging::
> +
> +    python3 - <<'PY'
> +    from pathlib import Path
> +    image = Path('.output/u-boot.bin').read_bytes()
> +    assert image[56:60] == b'ARM\x64'
> +    size = int.from_bytes(image[16:24], 'little')
> +    assert size >= len(image)
> +    Path('.output/u-boot-padded.bin').write_bytes(image.ljust(size, b'\0'))
> +    PY
> +    mkbootimg --header_version 3 --kernel .output/u-boot-padded.bin \
> +        --output .output/boot.img
> +    fastboot boot .output/boot.img
> [..]

Is the alignment thing why I couldn't make v3 images that boot? 
Interesting!!

These devices' ABL supports earlier images just fine though, so I've 
been using

mkbootimg --kernel_offset 0x8000 --pagesize 4096 --os_patch_level 
2028-09-21 \
     --kernel <(cat <(gzip --stdout .output/u-boot-nodtb.bin) \
.output/dts/upstream/src/arm64/qcom/sm6115-motorola-cebu-tianma.dtb) \
     --ramdisk ~/empty.gz -o /tmp/uboot.img

(with v1 images a gzipped empty file as ramdisk seemed to be required 
sometimes at least)


Thanks,
~val

