Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96465C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 14:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C88660709;
	Mon, 27 Jul 2026 14:49:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BLVK9JaRfX0Q; Mon, 27 Jul 2026 14:49:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C580606F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785163741;
	bh=26d1J6xy0k77WRF2YN6ClDDB1OfHg3StHpmtIMb5Xlc=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=M4M8JsqK2o8GI9GZeeB8a1zMeo8G36a8Wvut5hjvuYz29f6BZqJd38BAZILqeWmff
	 adgVw8ktLWzK9rTEXtxfs+KUT2HBz6pKFuhGeDuQSPVQ2W7MWNVJ7v8Uv8/+zK9YP1
	 XUXNUoeIjeMWicI7RodjEc/YRgUrVnSvaessUaKyxjaP6v0HHBIBDkew+5XyLyZzA0
	 RS4okrCc4+vPljjsiditGnc6TyDqBjg1ctaRVbS6F6fhynMbHzku5bQAxUJXqpg3Hc
	 5Pq26whBck+FMFQQ0z87oOeU10qF8ympXrQROC2rFf+j6UKD4+m69+fkMB8+x4lttH
	 nYSk9EVvs4N9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C580606F4;
	Mon, 27 Jul 2026 14:49:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A90439E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 14:48:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67D2D40140
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 14:48:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1PZQ09s3M_40 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 14:48:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4142B40063
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4142B40063
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4142B40063
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 14:48:57 +0000 (UTC)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C8E5B3FE21
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 14:48:55 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49544a639e9so15041695e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785163735; x=1785768535;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=26d1J6xy0k77WRF2YN6ClDDB1OfHg3StHpmtIMb5Xlc=;
 b=do2B/a865dWhtkgWfELYicENsJIBSXmyHp2mGMbUpY0MGG6qqkGLRpc3rH/wsPQLuH
 GIKYv/C2ptlUl/+E4o0tFxkyktM2dC/CCQYDExD9Zv3uMUqQAfxjoCI6J0GlXKSA/sPg
 9Z1Otj1juBaSjeHVgWpN0vodFNpybar0Kf4la2ltT1TbOamZtFZvxES0esonjhrenHbG
 Lqt8uKQknrK1fhh4xs3dgPOy9c7agJxfRPF2MMvYqV8X148Vx8x8GrEeSPclfsCWz9Aa
 5XMdsvhId6I4t+vCfIlKL524ACBsf3O7VxH7/rzQwxsvsr+bbRVAY3vLrUu6RxjHd+EC
 KPhw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rov1EaAf6wTxOetsT+sKkhJ9dqWUOKMOurQSfM2APuMPmUV1LhtOE1A2+B4yl7ht0oYqoSTfWw=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxaaOj1oyCCQDU+W62BrVJQ2iXxBdVOI8WYIMytNXIK8Ava2xfv
 fdFy1UxFWFoHwyUA3fyOS26kjDJg/bIJCFmRbooVpVJzhjoMUoK8qeqO6z3rKFfHXbae5wUVVpr
 597kkrO22vg8CutwvT99lfIhIngwQbiBkXEEoytwlRKtw10TlZV88ZbtUg1XbD1koioJXVwQ0v8
 snW23GPRpk6Q==
X-Gm-Gg: AR+sD10DTGR6JvGgkP02Hk8dFkTKLzEGQ8CMzjWA/tPB2QHQlaVgWigOV/q0U9mgQnx
 l4gK76JwVmmqTKrTjaX4/ikOPIAXa8jtppVDZ1I2wp1qy+4G3EivxvzD19naSFqqjIyJa5LwN9V
 zwsvbDKhDdV4VtPBPZy/CIifKefUX9c61ZaP+9hjcHEDGs8xYtBGSsiVlqQpZAZHb4MkU7mNXzx
 SaMQQ/xUTnUhSmIlhesRHn4/jqLupjrfElxnVh4EkS/sBFUkrowKDxW3LHbccrf8ZvwzXlEn4g9
 obUbMny1I99gvPGNgCrAdx++mvDpVZgFrZbAqug7ILizmHfCkYBwqpsE29k/Ind82g119LIf19N
 z6YiychXCHU2ei2NCLxX+kYWL+Ly/2mLsrifMMpFFGFid1rSF095Qzj4TTROS/kkpVsBekBwnHf
 TrDxx0rLH8MCpAWzGCJTo=
X-Received: by 2002:a05:600c:4455:b0:494:6baa:ccef with SMTP id
 5b1f17b1804b1-496b5717757mr101629305e9.11.1785163735350; 
 Mon, 27 Jul 2026 07:48:55 -0700 (PDT)
X-Received: by 2002:a05:600c:4455:b0:494:6baa:ccef with SMTP id
 5b1f17b1804b1-496b5717757mr101629065e9.11.1785163734872; 
 Mon, 27 Jul 2026 07:48:54 -0700 (PDT)
Received: from ?IPV6:2a02:908:1242:30e0:c0:45a9:2f65:4a27?
 ([2a02:908:1242:30e0:c0:45a9:2f65:4a27])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6e9a2sm51557897f8f.35.2026.07.27.07.48.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 07:48:54 -0700 (PDT)
Message-ID: <ef17dd5b-3536-4d24-96fc-41f58b87041c@canonical.com>
Date: Mon, 27 Jul 2026 16:48:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] efi_loader: check efi_deserialize_load_option() in
 get_dp_device()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Hem Parekh <hemparekh1596@gmail.com>,
 Kory Maincent <kory.maincent@bootlin.com>, u-boot@lists.u-boot-project.org
References: <20260727110336.71692-1-heinrich.schuchardt@canonical.com>
 <CAC_iWj+FgW-iqSLYH8vsdgeEis+Pc_EjKnnU3pMEdPbpgOjSbQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAC_iWj+FgW-iqSLYH8vsdgeEis+Pc_EjKnnU3pMEdPbpgOjSbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785163735;
 bh=26d1J6xy0k77WRF2YN6ClDDB1OfHg3StHpmtIMb5Xlc=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=b5i9olDMJCLIhDcn3THX3FhVhwwScmgQ4MCAxFsGQSkHhIHWQwZjPbUHpBSUHD9Go
 hbVSogUK5lQUc1GsLzFzbexIeucIMAIyBAIfg21JPTyUyoZmr1XqrkHkILa7Pt1EPq
 XMwjzyi0z/0ttGASSwkQhE6TSUzUIvPQV7Vq4TihdBxDC7beYb6c2D0bDSNCh8uX4C
 baZG9mvpiPaeaCd1NtfB5MFRI0TJTT1s1TJ9lTFThCLQkNL8clo+iGfcLoN6f5obLS
 6Qs8NwFSrb/ALcYmqrUMEuRTO4uc79AF81tPZBJxKoTUYjCqLh04BCGfEBayRJfsF/
 lb6Aa1oo7AnFY7Zcv+AesqmrcdtLZuU0C5y2GqNZ2KeSiEawEcj0eKjxu2ZBfxT79R
 uT/YPaf+hVEnqIHGIsBwEUZQlvmU9d5FXO3FQyoqjGpAPCgMTA3MSepCSoSk1ypqt9
 pI+V95h7LnRxgEQux6excIKroTpPCLW5Elcd06i/bXEneC/IBTzoew+p4NdL5+pGXC
 GHwJKxJoGxYbw2AqR5X9yIzxGiAt0ITp3fmkLZUc33oECKkmPlAoEpKurYsKAEp5ho
 M1vbB2ldbSDPQvivPDSdhnsWYd74eyIAviVIXU0/LMNsqkPchABOVawE2kCNqov0ea
 Ieof7ORv/uX2YdGIcQbaKSvU=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=b5i9olDM
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
From: Heinrich Schuchardt via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/27/26 13:29, Ilias Apalodimas wrote:
> Hi Heinrich
> 
> On Mon, 27 Jul 2026 at 14:03, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>>  From Hem Parekh <hemparekh1596@gmail.com>
> 
> This needs a :

Checkpatch complains if there is not matching Signed-off: for From:.
And Hem never properly signed the patch.

I will add the ':' when merging.

Thank you for reviewing.

Best regards

Heinrich

> 
>>
>> get_dp_device() reads a Boot#### variable and passes its contents to
>> efi_deserialize_load_option() but ignores the return value. On failure
>> efi_deserialize_load_option() may return without having initialised the
>> caller's struct efi_load_option, and even on a malformed device path it
>> sets lo.file_path before validating it with efi_dp_check_length().
>>
>> As a result get_dp_device() can proceed to walk lo.file_path with
>> efi_dp_split_file_path() (via efi_dp_dup()/efi_dp_size()) on a device
>> path that was never validated, or on an uninitialised pointer when the
>> variable is too short to be parsed. A device-path node with a length of
>> zero makes the walk loop forever, and a length below the 4-byte node
>> header leads to an out-of-bounds read. The Boot#### variable is
>> attacker-controlled in threat models where writing EFI variables does
>> not imply the ability to execute firmware code, so this is reachable
>> during capsule-on-disk processing at boot.
>>
>> Check the return value and bail out, as every other caller of
>> efi_deserialize_load_option() already does.
>>
>> Suggested-by: Hem Parekh <hemparekh1596@gmail.com>
> 
> And you probably dont need this if you want to keep Hem as the author
> 
>> Cc: Hem Parekh <hemparekh1596@gmail.com>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>>          Use common exit out:
>>          Remove invalid Signed-off-by: Hem Parekh <your.real@email.com>
>>          Changed error message: remove word 'for'
>> ---
>>   lib/efi_loader/efi_capsule.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
>> index 52887f7c274..a77810fa15c 100644
>> --- a/lib/efi_loader/efi_capsule.c
>> +++ b/lib/efi_loader/efi_capsule.c
>> @@ -860,7 +860,11 @@ static efi_status_t get_dp_device(u16 *boot_var,
>>          if (!buf)
>>                  return EFI_NOT_FOUND;
>>
>> -       efi_deserialize_load_option(&lo, buf, &size);
>> +       ret = efi_deserialize_load_option(&lo, buf, &size);
>> +       if (ret != EFI_SUCCESS) {
>> +               log_err("Invalid load option %ls\n", boot_var);
>> +               goto out;
> 
> efi_deserialize_load_option() will only return EFI_INVALID_PARAMETER.
> For the capsule update on disk this seems correct as the EFI spec says
> "Invalid capsule size, or an incompatible set of flags were set in the
> capsule header. In the case of a capsule file, the file size was not
> valid or an error was detected in the internal structure of the file."
> We just have to make sure that we either explicitly set it or
> efi_deserialize_load_option() doesn't return something invalid in the
> future
> 
> In any case
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
> 
>                                                                    │
> 
>> +       }
>>
>>          if (lo.attributes & LOAD_OPTION_ACTIVE) {
>>                  efi_dp_split_file_path(lo.file_path, device_dp, &file_dp);
>> @@ -871,6 +875,7 @@ static efi_status_t get_dp_device(u16 *boot_var,
>>                  ret = EFI_NOT_FOUND;
>>          }
>>
>> +out:
>>          free(buf);
>>
>>          return ret;
>> --
>> 2.53.0
>>

