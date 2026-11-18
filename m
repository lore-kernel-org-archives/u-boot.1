Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D5D606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iAqK3PWp;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=G/ZuSfJn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0439160A8E;
	Wed, 18 Nov 2026 16:02:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VdoF19SG6LiK; Wed, 18 Nov 2026 16:02:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8E21560A7B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795017725;
	b=kzLmUnJKYXhGIiygH9NvACtFhlV4m0HUAEv6aHm8uWbb10fcjQgwdT4r07ZMct4XZtfN
	 +uVJBgtoSyNwEdwBTJkSqycA8CyHaE8+C2tD2UGb0/OMIun9pLJLLzndpXXgVnPLmsMEF
	 Co31qgFy9EuWr+dw0JVMfj+uZCh6RHlw5Yc183z1gLul+Cwyj9E64PIKkuZhVN1xq80Ml
	 CkOGVrYGV6c9sVkO5tUzfJbvDm8rSLL/4baBNe/WUEW2eRqzlL6kPdkYXfJje//wLot9I
	 Xn8cO/n1Do6GDXcZEmWBYgn3+c6cSX8GGXSWhUOmwp5MP8QhOh+DAOezWVYuVEi8NDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795017725;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 X-Google-Original-From:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qN53Yfkgxoj7xc6/mMTmtsrGnGAyWLRxkj1yBWKfXSk=;
	b=Dtmv8LXxd4bo1RBAcgaa32MU+MnNGYgurNN8NAYFfiCQqnyuGHhjdFWs98sNw2qHyF4Q
	 8crBWeOpzP4H/WInMSfahHop6Oi0aWNO6stVSxlIgi8OS+C9QHJwc+1iaqnUTj6NHgufN
	 gnlw3O36HavNkWWYD1nYRzzL2l4+PkHvoxHhAxeVPFRFD82oscoRMS6YCbQjKvGPRm68n
	 y540zL4yphIgRh3w9nr0zhWFwzZZ5SR/BFvHdhnbpmmvST9yg+qJAw9WK7yd41voKwwQ0
	 DvkEBoIte8TcXFXk6lwJ5js+SqK8Ex8pv1bQoKJ/rR59we7ePlxMMSScpnfUZQAj5eA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795017725;
	bh=qN53Yfkgxoj7xc6/mMTmtsrGnGAyWLRxkj1yBWKfXSk=;
	h=From:Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iAqK3PWpEeP91hC2PXv/86U4osgQwykhyXIwWGU7Bi4uPTHppMJxphkwJ0p3iANpx
	 Uom6uC/GQH2C/rCZlXS3X6r9JxxBIM5iBKCg0xyFPUSSwjhkQfAoxbYwB9VuglWjPY
	 DEGKhuQsyXU9uYTgrdMbbZ7G8hRkKTHa9lfPZ+64288kCPnKqb7aOBM8lT5NDxcJlf
	 iyI4Mt4ZZT65FzlXFCj1zXD+0Ku9UIff5IU24OZ9DysK7vUU0dIcQBoM8MnzDOTHz+
	 1tpyDvJWFt2RoJ78mTtRw2hmlypLCwaYaNVwZhyy+9wIvONrz5RPVoOCrvePtswuUg
	 vYrFBoU/6OiRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E21560A7B;
	Wed, 18 Nov 2026 16:02:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C242A0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 295AA81129
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:02:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ra2W0yvHS55d for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 16:02:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8A73D80EB3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=G/ZuSfJn
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A73D80EB3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:02:00 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D75CF3F491
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795017717;
 bh=qN53Yfkgxoj7xc6/mMTmtsrGnGAyWLRxkj1yBWKfXSk=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=G/ZuSfJnUuXGiPXVg/P1Pt6UiDNs9l1PG3EiuWD3nJw8vy58DdqvwN0cju3KcjnKm
 36oBIes2GWswPlko+xmCv9JVGwhyqQBCQhab5bZFz5WLjTYl5oNpNAusNLffZtDW+r
 Vgc/Ue7+MHPc4MS/bIfR+KSLrkvfyefcDKSZCQGbW2F/u67fj5gHumqDIh48p/QRa3
 dtIfLcyxUJVfNIcYd7LgZLucFc3KGivingOCH/AzNRnKcfatwwLUTDC/3wHOLf/Vn5
 n1hTST0mwAXcphIajPqULQRQdImZRgT3axYG8CyI9xjVJn2UGGX5G24fqyjodV8ZY4
 p9rInBVpWs55qkzXu6AOApyTSiDd8sK3nqc8U8jdem5tAfcvi1wZIMy3inkVzV4+Za
 ICFcV/ON8bB3RV2IQs+MApoj85UhdwWHn+mbvq24STq7KVIxppmK75VmDwFfZe2qTK
 CsxxPeS2II7g2l8efnMV5LnE8QgjCkxOPjB4dbKgJ4sO7N9KdPETHpKmrUMXQFZbiG
 ko+R2kAx5PufgQqPJb+TWVwis5erNfy4vo1GJZKIoVJc0MAu2n6SFND2e70HVRaXRH
 p87+LEYclXPvBDI/BNInqm8RmnyQyy43JcN8+AzmmbCdZWZ/NRdAvuqrUrD9pzCRoB
 dZ6mM9Wp0zkfkINlxs+bARwM=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a359b714f8so7617615e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 08:01:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795017717; x=1795622517;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qN53Yfkgxoj7xc6/mMTmtsrGnGAyWLRxkj1yBWKfXSk=;
 b=HAnWpW7v4OEmbjR7uTi0G0btTWfuOZO9zvtXvBbNTlxn8LIkN5VNDpB3BoHIix58Yh
 xvpmPwc7p3Hvczs0U/VDqnV9Slfcp4qRf1k8uhhbjkR3yzCwqUk2RF+oatYtlZ0TKBZp
 8GSETjkM/z6N50nmW5lnp29kDwflSSfYd/fsukJuaVbiQFuiKqQepYdmNID8dcL4NiZ3
 GQRQQWfVxiI6CFRMxSq2BDdkfr957ZfXqdpzn+1O2gJUrmp5GXMugvkp1izu9sFTRHa7
 9q0qIOr1zaSbNd4fMhzqINClaqvuMEnpUlcBHIQtm33Aqhu7dgIJMM4TV4XLE4xbaOwf
 ooiw==
X-Forwarded-Encrypted: i=1;
 AL+hErHWZViAKYcV6lKyJ50W2996Q+ASrbTb5AqGgEd25RzF6xPqeR1ePseGhVJrFIiuLrNw9JcF8d4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8meRSkAuUb1t5n/70IthD1yP3c8ggzgcjTHXMTHh92HWaFhzC2
 VYbXLbZojmjgHIxFhYVD3TXaralUAeXnYn08dfkiccs7zBpWxq6yqRkfoHEytfqecqwvQmdwXGR
 FOKiDHXFWm2sdFt3HTSeKWfnj5Tqv6JNQCHu0E13E7vRH2Z9Ns9Tf+N8ZU8VoKfauV+/iPykDwD
 B9SUinbyrK7w==
X-Gm-Gg: AYBFou2M/PdXkY35HX9Ig+Q0jDW2Yufw01ad+gwglEVy+bIZIzQ6qTA//5UCtF/Wa6B
 DdYo1boqm9Az0EdBwqtDwMwQuXX6wjOqDJ+a/Fi7UduvWvw5rqw0eHGVfXGcKSKVsgzTL39n+/s
 MIzsP/dLDRwR1r4AkW8hlH9URqbCZsmeww4XbIH1P4JsGaP8ZPjzsgc24WFSH3uUzOzR6ORcpuv
 YhwweZZSOmLcjBkpiHyXmTmm8QDW5grWfvMDFvbQywQc2GjAAj3mYCYbYoqKZmyl7aug+ld/kRj
 4WG78BnzoHq7GUgRB/Lrk/bXfq09TfDq4oVw5vM1K6PqV8NagJdbs/TfT1M9X1mBgTc5UJ/3IwO
 lrXy8DUMJjrdIxYy6x9PL+nXOyKSLHWoCVfsL+TBAdcpeqGDZHnP5z9PMN2naXNn+T6rVrteh+6
 41+7IvmchJWZ8cHoExlRra1U1ZufwX99TgUO4v5BhG5Bh9xtkMbVWpkfDh
X-Received: by 2002:a05:600c:4595:b0:4bb:5c97:f4b1 with SMTP id
 5b1f17b1804b1-4bb7da3532cmr64815755e9.24.1795017717455; 
 Wed, 18 Nov 2026 08:01:57 -0800 (PST)
X-Received: by 2002:a05:600c:4595:b0:4bb:5c97:f4b1 with SMTP id
 5b1f17b1804b1-4bb7da3532cmr64815255e9.24.1795017716990; 
 Wed, 18 Nov 2026 08:01:56 -0800 (PST)
Received: from ?IPV6:2a02:908:1242:30e0:a017:1403:86b3:9a38?
 ([2a02:908:1242:30e0:a017:1403:86b3:9a38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78418853sm215944795e9.8.2026.11.18.08.01.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 08:01:56 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <cdd58082-06b2-4581-abbd-0e585b928291@gmx.de>
Date: Wed, 18 Nov 2026 17:01:54 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot: pxe: pass the initrd to EFI applications
To: Junhui Liu <junhui.liu@pigmoral.tech>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>,
 Alexey Charkov <alchark@flipper.net>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Tim Surber <me@timsurber.de>
References: <2113981400.38169.1794275897389@app.mailbox.org>
 <DMYG3PDX1XU2.1CEBB4VRVJHNC@pigmoral.tech>
Content-Language: en-US
In-Reply-To: <DMYG3PDX1XU2.1CEBB4VRVJHNC@pigmoral.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 16:35, Junhui Liu wrote:
> Hi Tim,
> 
> Thanks for your work.
> 
> On Tue Nov 10, 2026 at 9:58 AM CST, Tim Surber wrote:
>> Since commit 841abbc6d561 ("boot: pxe: support booting PE/COFF EFI
>> applications") label_boot() runs every image with a PE/COFF header via
>> efi_binary_run(). That includes regular arm64 distro kernels, which
>> carry both the "MZ" PE header and the ARM64 Image magic and were booted
>> with booti before.
>>
>> The initrd named in the label is still loaded to ramdisk_addr_r, but it
>> is not handed to efi_binary_run(), so the EFI stub starts the kernel
>> without an initramfs. With a stock Debian arm64 kernel (storage drivers
>> and ext4 as modules, root=UUID=) this ends in
>>
>>    VFS: Cannot open root device "UUID=..." or unknown-block(0,0): error -6
>>    Kernel panic - not syncing: VFS: Unable to mount root fs
>>
>> Pass the loaded initrd to efi_binary_run(), which installs it with
>> efi_install_initrd() so the EFI stub can fetch it through the
>> LoadFile2 initrd protocol.
>>
>> Tested on FriendlyElec CM3588 NAS (RK3588) with Debian linux-image-arm64
>> Fixes: 841abbc6d561 ("boot: pxe: support booting PE/COFF EFI applications")
>> Signed-off-by: Tim Surber <me@timsurber.de>
>> ---
>>   boot/pxe_utils.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
>> index c60429a5e1..21b05ff9da 100644
>> --- a/boot/pxe_utils.c
>> +++ b/boot/pxe_utils.c
>> @@ -807,13 +807,22 @@ int label_boot(struct pxe_context *ctx, struct pxe_label *label)
>>          if (IS_ENABLED(CONFIG_CMD_BOOTEFI) &&
>>              efi_check_pe(buf, kernel_size, NULL) == EFI_SUCCESS) {
>>                  void *fdt = EFI_FDT_USE_INTERNAL;
>> +               void *initrd = NULL;
>> +               size_t initrd_sz = 0;
>>                  efi_status_t efi_ret;
>>   
>>                  log_debug("using bootefi\n");
>>                  if (bootm_argv[3])
>>                          fdt = map_sysmem(hextoul(bootm_argv[3], NULL), 0);
>>   
>> -               efi_ret = efi_binary_run(buf, kernel_size, fdt, NULL, 0);
>> +               /* hand the initrd to the EFI stub via LoadFile2 */
>> +               if (initrd_addr_str && initrd_addr_str != kernel_addr) {
>> +                       initrd = map_sysmem(hextoul(initrd_addr_str, NULL), 0);
>> +                       initrd_sz = hextoul(initrd_filesize, NULL);
>> +               }
>> +
>> +               efi_ret = efi_binary_run(buf, kernel_size, fdt, initrd,
>> +                                        initrd_sz);
>>                  if (efi_ret != EFI_SUCCESS)
>>                          log_err("efi_binary_run failed (ret=%lu)\n", efi_ret);
>>          /* Try bootm for legacy and FIT format image */
> 
> Your patch fixes the missing initramfs in my PXE boot setup on my
> several RISC-V boards.
> 
> However, the tabs in this patch seem to have been replaced with spaces.
> This also affects the context lines, so b4 shazam fails to apply it:
> 
>    Applying: boot: pxe: pass the initrd to EFI applications
>    Using index info to reconstruct a base tree...
>    Patch failed at 0001 boot: pxe: pass the initrd to EFI applications
>    error: patch failed: boot/pxe_utils.c:807
>    error: boot/pxe_utils.c: patch does not apply
>    error: Did you hand edit your patch?
> 
> I had to apply it with git apply --ignore-whitespace. Could you please
> check and resend it with the tabs preserved?
> 

Hello Aswin, hello Junhui,

Function label_boot() is called by this call sequence:
extlinux_boot->pxe_process->handle_pxe_menu->label_boot

But also by bls_boot() and extlinux_pxe_boot->pxe_process.

The description of 841abbc6d561 ("boot: pxe: support booting PE/COFF EFI 
applications") sounded like it would only concern network booting via 
boot method PXE and not other boot methods like extlinux and bls and 
specifically not booting from block devices.

The extlinux boot method before 841abbc6d561 booted via the Linux legacy 
entry point and not via EFI.

If a change of the bls and extlinux boot methods is intended, this 
should be clearly communicated.

Best regards

Heinrich
