Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4014606A32A
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uBT2Sxu4;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=gq6bHSZH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A240F40569;
	Sun, 22 Nov 2026 13:06:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hNq-rnmXEQwv; Sun, 22 Nov 2026 13:06:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7D334404EB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795352762;
	b=fBm3PGhWpdpP3BBDOIrsLjFkk38IyCJKja0j0yrcFklc+AfvIL1Mjwcf955HpSBsoL4m
	 DEW6/ZyrxyZ0S0mOBP6dCAipk8XoKg26hq8w5demVRSe//FrrLnQ74BDq7nnN/aV8dfzC
	 19+iqPyZfqknMD824qezIy9fIGXDFUxKA83eNh/AWNGvwnB+eog2Z9JUbSXkepy0aKUUc
	 tpYlkh5a+u53IpIDqT7DuToPclh2oP/Pgs9wC8PKXHl3i+HUF7yU32uzJpxd0bKsbUdlc
	 aZpRF9iTKdocxBK5gPba/xi8BkCDMAboBJ5iYaNJRv24vvC/pLWPMTQbMLDTx9ou5Yg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795352762;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vkOPQmvRgFzveD3aT8p15+32OydmJ4sAxIbuxWFyGjM=;
	b=Bgd9jZzLPAPYXohw2FgdcIGUITt4DfBjt1/iDz+W3tUluCQ2pdtI624k7oHXPzjatgHB
	 pgiPkZ491HHxJyTzdm5BpYj5RR1VjA4QMDNghxQAVM70j6rlkGAl11tXbAqZU7dOfj5BI
	 icfD04JiIf9xeZaHrnRV4h13MOl2OsGlnpzawGojBTeNfAkBdJqouE2yuIVM+l+PdBQyg
	 L0yu5teYsjPu6QDLlgciS0Lmy+bdxm0I3j5fQXhymzep9qRj8p5unaWHb5tSxFua09LDI
	 aSyWH7Ow/2V4Fryu0Ep/t5ScADBL/Ek5O7vmOixQNO8gm1iOwTzBCszrX8e0HYrpmNw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795352762;
	bh=vkOPQmvRgFzveD3aT8p15+32OydmJ4sAxIbuxWFyGjM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uBT2Sxu4jw8xJAmcnvtfJt0gSCJJ9mnX6CVs1sC7esgv0rDWE2Ai8J8AEcPkhSA63
	 bQb3dQpGIeGORwk7I0IWQ4FVkxOF7t2rV1yFWPRjor9Y6zLnUn4yPwDnd5o/9JerzB
	 7Ry1w/Z8CXChb/trM4Ysy2U4VyVzXEo6bpUlFmxHaftoAATQeBlbiOZmlmqsis7+ja
	 kp6sTXFsLeb7SQWYQ/1coDVms8okbB3WaOoI/1BPFFVR3yuK7qoYy+BtFx6/oQpHFF
	 1xUwB0O0HyL7/ABe+2MlApn+HNjI8SH8SrMI4SZ6s3+2Mq3wOuqo9S2EkVxKzXKW3J
	 dhV/QahsKh+Aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D334404EB;
	Sun, 22 Nov 2026 13:06:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A29A322B
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 13:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 878CF60607
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 13:06:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2HjSHzFWjfpX for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 13:06:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D63D1605D6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=gq6bHSZH
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D63D1605D6
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 13:05:58 +0000 (UTC)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 06B083F19A
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 13:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795352757;
 bh=vkOPQmvRgFzveD3aT8p15+32OydmJ4sAxIbuxWFyGjM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=gq6bHSZHYtmsORgxar2dwORNRWbNTyLIF89ALU6aTXPcuiCqjf6aDQI5GjGvmgE6G
 6bQ6Roq6b0daxCDlXHuZIP357Q7OWc0ucimuFVHW3kxLEi1hFUTNIbLCBCT0jx4Xv+
 hNsIzE3fBk4BMQNziF20qRz3oHXIgQyvgh05AJ7DdL0B8AJKqXPbhDEJILCQlD2W+f
 mWerr06To6z3+xNTDPJfczYcIgIl0Zomttaco8WmsLoUa9bNOGtv51Sds2h3w6afiQ
 dUucTwBBYKrIsRdANEyh7uAsne7L6z7/36cyHpvAkHGKGq+zY/ZXgQuSYTr07Oor2i
 2vQUm+WNAYOkOo3HzGvf5jqmnIGFEFIxr6TbgWX34PR3nOqe4rtv8lGt5JAC1G0+gH
 gAKCx7Gj3AE1eqftPrnEHcox4guQLitzgr1yvrpmIXr6szYWv6Mhhhuc8jxuUjwIKz
 bjUHMf6mUIFpUB3lSghziiId2CtvZP/9rYX4l6ERlfCtQQv+usCZwCKKH2V0u4I+ze
 +D/bfPpDrM38pq0L+UOMQc3HQ+7zl/wpZJzd0CzCaJDpgaoFxb4mu7B0tc68uCJF2F
 4PFqAMz9yyskbXOho1XIIsJbK7HKoMjZjUBnrYfwcRIC//bSyrmlpUB9KEAoXV0Woz
 /APrFU/RSbs2VtzMnLxlPjaA=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-49337a224a8so1428343f8f.3
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 05:05:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795352756; x=1795957556;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vkOPQmvRgFzveD3aT8p15+32OydmJ4sAxIbuxWFyGjM=;
 b=tqg7eFSeltgquLikMk+nxcpch1grbGiDdXNEDa5jEif5vEnSiApPIWWRwVC6we8O6t
 QV8h0NA84JV3R1QFgPKxe3SVEYXtE+OgIf3WOk5+rkKakigFRSkERXeYIsE25UQhpzt6
 8pjJDVCqyda/FnNNTqnEtBMcpJFSouU2EzfA8ritShR9zxTdW+84nXm8j8/UB+ff2atO
 Y7SvCLZVKGRNJWch9RgBm2Irqb9y4QQ+VmygdJvzRd2zryyv07NegWADOOQCC1Ft4cVO
 E0NqjqFzMy2dcvvInmP4ovOfFLtaTmTsNVvlwcSf+15bM0eZZZkac/0BWKgYr+WkraCK
 ie9w==
X-Forwarded-Encrypted: i=1;
 AL+hErHtTcK5QF7utDMfKkkKhd9XJx7FfY9gV21YtM2pmzWiBPrDg16u1vi01RarigWXSVPN4qko+X0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9FPZnWU6Vv9X0DCJKKGXd7K1Oedk+S9SQuzxeNAJSylx28w6PY
 R3LDHORS9JOWyy05IidLSN9+qFFCwBHZL0tp0bCL7J3eCx/yDzJVjns9XO0bPl5mIP/z/KLGQPS
 dnenL7DgY7nqfahc07PMAGhc2+wwXZrGyxGpGKuPym1OcvsDa8VmgGRLH+H9DUpjC8PVlwiSQbP
 vXE464+TX6+g==
X-Gm-Gg: AZFdTZfubav7UbqdbGfEJE4HZm5JjvRbEaGDerS1tdUEPUPN/gD4qQ4o8qactdi7Av3
 Bes3OS0qEu34BLiEoAxVPApDIIqCZXE7psEMvO4F72x7ehz7lrEX1JMHdcz5H0KwTl7LQIF84mg
 NU/kDclEAt1lpKHZsJczndXvH8xgLVFJBTQ9wPvdU3g4S+fcFc6YAzQS0aY7E7PfXibRd2WdX2X
 7FvmrzO5hFL/153TZXLSE/Akx1NgHek5Qt46Cz2x2bjCf4b3eFLMBDiXtoG6IDTT4+KQRv1CRQd
 4ntyA8xa0udv63eDUvVKY9we0OpwBLSIhZxqir1NTxZiBQbVLYeMZK2WjEpsV6TZ2Wx9/Wz9RY2
 XATL7JmwFIDQaHuGZ5yy3lfHbwD0tEXCzFuffQE74wdMLX8SttmFLpFkVbqCGivQgpkvKQWag/s
 7ZbtRYEjcmuUHU8Kqc3FduGYjd3pxWyXEoQoHGXexnL3hGCEXTs/1n85vYvdTTy57LwwYUVul5X
 Q==
X-Received: by 2002:a05:600c:3b8a:b0:4ba:761:c0c5 with SMTP id
 5b1f17b1804b1-4bb8880f0e0mr189175895e9.5.1795352756629; 
 Sun, 22 Nov 2026 05:05:56 -0800 (PST)
X-Received: by 2002:a05:600c:3b8a:b0:4ba:761:c0c5 with SMTP id
 5b1f17b1804b1-4bb8880f0e0mr189175735e9.5.1795352756281; 
 Sun, 22 Nov 2026 05:05:56 -0800 (PST)
Received: from ?IPV6:2a02:908:1242:30e0:df4e:103b:d7fc:c354?
 ([2a02:908:1242:30e0:df4e:103b:d7fc:c354])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9687sm305061365e9.10.2026.11.22.05.05.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Nov 2026 05:05:55 -0800 (PST)
Message-ID: <336aeca3-40b4-46df-9f0c-c5e7e2ed219c@canonical.com>
Date: Sun, 22 Nov 2026 14:05:54 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: correct EFI_SYSTEM_TABLE_POINTER crc32
To: Paul Liu <paul.liu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261122003312.134216-1-heinrich.schuchardt@canonical.com>
 <CALG-KHxRgynXggzr36JRLRHC0H_c5fNDzTzCnn_J+WvLaF9tFw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CALG-KHxRgynXggzr36JRLRHC0H_c5fNDzTzCnn_J+WvLaF9tFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/22/26 13:37, Paul Liu wrote:
> Hi Heinrich,
> 
> Thanks for the patch. But I can only see the UEFI spec 2.11 right now. I 
> cannot access spec 2.12 yet.
> But the patch seems ok to me.
> And I think we also need to change EDK2 right? Not only the way to 
> calculate the CRC32 in MdeModulePkg/Core/Dxe/Misc/DebugImageInfo.c, but 
> also the gdb plugin BaseTools/Scripts/efi_debugging.py

Hello Paul,

The EDK II patch is in
https://github.com/tianocore/edk2/pull/13555

Linaro is a UEFI Forum member. You should be able to request access to 
the USWG group. https://members.uefi.org/site/login has a button to 
register using your Linaro email address.

Other teams that might interest you are:

ASWG - ACPI Specification Working Group
UTWG - UEFI testing working group

Best regards

Heinrich

> .
> 
> Yours,
> Paul
> 
> On Sun, 22 Nov 2026 at 00:33, Heinrich Schuchardt 
> <heinrich.schuchardt@canonical.com 
> <mailto:heinrich.schuchardt@canonical.com>> wrote:
> 
>     The UEFI specification 2.12 draft clarifies that the crc32 value
>     must not include padding bytes at the end of the structure but
>     instead should only be calculated over the exactly 20 bytes of
>     the fields defining the structure (Mantis 2521).
> 
>     Fixes: aaf7be96c2c1 ("efi: add EFI_SYSTEM_TABLE_POINTER for debug")
>     Signed-off-by: Heinrich Schuchardt
>     <heinrich.schuchardt@canonical.com
>     <mailto:heinrich.schuchardt@canonical.com>>
>     ---
>       lib/efi_loader/efi_debug_support.c | 5 ++++-
>       1 file changed, 4 insertions(+), 1 deletion(-)
> 
>     diff --git a/lib/efi_loader/efi_debug_support.c b/lib/efi_loader/
>     efi_debug_support.c
>     index 8d0c133871e..e191e5121e3 100644
>     --- a/lib/efi_loader/efi_debug_support.c
>     +++ b/lib/efi_loader/efi_debug_support.c
>     @@ -45,9 +45,12 @@ efi_status_t
>     efi_initialize_system_table_pointer(void)
> 
>              systab_pointer->signature = EFI_SYSTEM_TABLE_SIGNATURE;
>              systab_pointer->efi_system_table_base = (uintptr_t)&systab;
>     +       /* Don't include trailing padding bytes in CRC32. */
>              systab_pointer->crc32 = crc32(0,
>                                            (const unsigned char
>     *)systab_pointer,
>     -                                     sizeof(struct
>     efi_system_table_pointer));
>     +                                     offsetof(struct
>     efi_system_table_pointer,
>     +                                              crc32) +
>     +                                     sizeof(systab_pointer->crc32));
> 
>              return EFI_SUCCESS;
>       }
>     -- 
>     2.53.0
> 

