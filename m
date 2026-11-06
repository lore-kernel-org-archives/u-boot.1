Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F760606A32E
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WwlmDtzW;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MQTqclY3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 250C7408FB;
	Fri,  6 Nov 2026 09:42:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KILSSGClWt3k; Fri,  6 Nov 2026 09:42:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6552B408E8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793958147;
	b=TarBG0pve0O5O2F2Xqn0FW4gLEPen35Z//Yjw5iKjIyhLW5+P9q9ZTDsDvcXWFEdzj3o
	 KZXWHV8BlPdjvHDNhgUhXvq45oQhrKbKHPNyNYHu/LqBz3O9FKt9qyT2BQhZg37kwRfMJ
	 jfpS/JBqI9cXEDu08qb5mFPCvzepzmhl7Qv94SdzwZesABz6wmVxJrTfEG383okgj81Zc
	 HloHcMS2F8alfZeRZogXJNyabqT+tHd3IAjJs0Kgzm+Ket+VnT2JKfR4c7Dsl3cDRbkUb
	 tjryAH8hjEgZnuZys8GQkFZ8cQ0n2hbb7tcdgeGV9FBk8tB4sFbzHChGSwcg21jPfnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793958147;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=p/Pc6Vn+NG32qef6YxcD8miWOp5mPO39aTCJWw6mLnM=;
	b=ZrjTTrpG3g8TzHQa3n3sXgcQIfNEj3wuEkBi0aEktJPK9g7vetUpwT86xncfubvkGbof
	 gktqAyBOW1KcNxoxdjpg5uVWw4h8U/K3xlyRJrhPmEcz8OF3UEjI7tE4SHmjnQl0fvbhb
	 w1n5lsP153k0ZlO35nUqUpvB9KvxthqxNTiTX8piBn7LV0B5rTvv3WlMoJ82tNNCjapTS
	 A60jnc/TwjX0/qRWIe6Ri6/kpISeixSK/ps5qDfQwChRUHGqyTpjlUnoEDWL1aikoJmpP
	 JNeLpP9yQYf+oarrdUwc7pi63RR8C+ZPS80WY3PMGvRWragE/xApPQvscxc3in97DZg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793958147;
	bh=p/Pc6Vn+NG32qef6YxcD8miWOp5mPO39aTCJWw6mLnM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WwlmDtzWkU7s7X8STlmVTvFdWJG+0a3OulrMoIR6ucr7krJIH7KhC0qpLoZRmV0P6
	 4tBL575uQdDXvYxrvnhJPz+B6jI0hgMteRE29rPzhJ9qiQzKua1pvERxGZDc88MCVk
	 Jln4FVPlVL7vKC9UdrOEm61jvw1saMC0YSi/dA1+OtyKjIHgM5cIjMTotmsfFHV2ti
	 D8IImjCp+j4WdCjxQCAT+eJGYJ1Llg1B62OZXsabpkBLCmCC64qKrJpsohlImDhRpy
	 rDugB2C1Z3wxUbVMWULzU72mpOkKWfKm/gIv0sf0pR9QJfyrd9h61BZrgjMgl4BwWU
	 ikJOmGrAk7t9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6552B408E8;
	Fri,  6 Nov 2026 09:42:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DD2BB34D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:42:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE5E3403A6
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:42:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q1EnQaCCvlco for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 09:42:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B1D76400D5
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=MQTqclY3
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1D76400D5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 09:42:23 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8b308fca7c3so2834177b3.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 01:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793958142; x=1794562942;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=p/Pc6Vn+NG32qef6YxcD8miWOp5mPO39aTCJWw6mLnM=;
 b=MQTqclY3gL7LqJsG4afSwAkiaAmI0RDCMWTFQ+XkyZyo72V0PvHMjMlJAqiqA/SXhC
 N6+0ayCRcRECN1T0Zv1qKFW+habwpo15NgTSPftlXJFwmj5RGjPfeSxY6qdFnxFY5fk3
 5P7qUdxXNtcGGPHA7claw4JXX6ByBi8fjTO7ofamA5spCZEAaC/WXJx8+5IEUZQ6v3h1
 8YPnFRG3sX7Eox76/09XXZ5oLy+MwNL6TjM4feckAayYWsxU4wNtqGbuG0o8bEZJ3huO
 zKvYAadoCwjna9sIfm4DBxrGrX4JWQtYB/LPYLrdPJU8A+4o/cW1bav+WfwYCjPhs9/t
 kTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793958142; x=1794562942;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=p/Pc6Vn+NG32qef6YxcD8miWOp5mPO39aTCJWw6mLnM=;
 b=wChy5FAmC6As9kf04GRXHhEDxGd8Ab70on4eaDJwjvJRRqqEKhmqLy0oo+s2xoenbi
 pq+qCEFPPYBsU5OH1GjvpJ+fDGZAtjr1NjKOo4muGpwTSxTPDpBuNdSc7CvAosIM7aBA
 KwbG6/74mOQxmqIIq/MFj+wlpcQBXirZFlnrnFrbMLTjCB7rguNYZP84c3uARQuIXT03
 Un7ry5gnK01mEotDZEIJM6YuzQJ2tekX2Zv4Wokm5z6I2PvODiyA2Mq5uMcMiNj9s6rX
 5Koc4AUswwU2aLUJIJ4NnV/CLlAi46lIfjbLEJFMauxl3C3yJNQ9i6SvN3WdKIv/YOnJ
 OKCg==
X-Forwarded-Encrypted: i=1;
 AL+hErGvz2SqRDhWukmBL3RxudeVNOQZrVrQeeWZm7tgYjzqZLbGA7yPq+3fw4yc6bSxXWZy81arPgc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/McgbCw8acPAITvy0aSYrZia306m2rcMbqIjS5kr0V2qt3aS/I
 LFE6xRYn8FDpLmTf1HMt0JTtXS+gCLeo9oworRSoltS8inbWTtUdXTfxqybMCWIUhUfDmyxVrhm
 URW0T/tjTpSnDfDiFWZzQXXoSwvVgojuim908UyKJFaJNdoY4rnODdAs=
X-Gm-Gg: AYBFou2Rd55+lkEcNI5LmTStCB65qet6wdoPELDwHhKYQCTh7FZrlK+TYVC3k+gOOOz
 qpfLS02uXABXFNLLVdTjZFWkMqD+0bwSezm8V/sziFB89an5eFzJjq22me5H0n7GFtW+LVaw2Cd
 OSPpfe8kc+8GZNKkB3yMj3hG6qL3zfdvrtvMZER6lxAIhwGTIFQiRg+JO9l6IzWjsfEARY+7Hy4
 yC10oHOnt35yNPjZ1X4hneZ5mmf+2QZwpFpLipLLr4SKlz+t/B1qIYrz4xgbbP+X4S2LE6ynyrh
 VKrWgZ30Wjr2/00Bj1oyITUnM+7Rlm/M3xvHQD6tBS3C8SQeFDCni0EjbNu9iK4sDadFj4J641Z
 pGpQQ4BksXo4vSO+r0rUzx6oWynmavkmtglkqVI8cZ8fNwMbNcQKLZen98sE1gypZqUJvzIM/8R
 yJlSrarxS9NxA0q+0THqf0QDt8DN5Drj0Z44vitEf8cJ587rWIEXNAijtROMytMpUVZXZQNCHKM
 xiD66W3MJVN0bGc2X55k3qzBMJjKkNCWCJUoewuVtuOiAjgltuKjUI7OwNqLf31ZANscy1mYJ6K
 SYEUp1cgnV6WUsOya7YsXIU7hHtE87AefVjz/ItgsqOSTQJOnwm9K6QcWjU0gbkTU0SwaF8xAkP
 KqH/6ceD7C+/Nl4B1vX3LZsbGbvL10iICmjynxIq9o6u9Cw6A8fGS2vdnNeC1HAe1S+2QPzBOZ9
 TbAtVsz9Q/KIgoybWyA/xhmV7gddc1lftuL65Z
X-Received: by 2002:a05:690c:a006:b0:8ab:3918:33d9 with SMTP id
 00721157ae682-8b341b65b54mr10482797b3.61.1793958142040; Fri, 06 Nov 2026
 01:42:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103085511.74079-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20261103085511.74079-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 6 Nov 2026 11:41:45 +0200
X-Gm-Features: AclHuK8U_kjTtN2q4mZqT8rhuJXP-yMOFkJ0XAIBlo7Ar_ZdgoVVjXqb1_RuPdU
Message-ID: <CAC_iWjJGgE-CwpMeSuWqcKC9sKa9jkmJG5WcQa7Vmhaw+w11eg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: handling of missing TPM in efi_load_pe()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heinrich,

On Tue, 3 Nov 2026 at 10:55, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> In efi_load_pe() if efi_image_authenticate() fails, we completely load the
> image and afterwards return EFI_SECURITY_VIOLATION.
>
> If the TPM device is not found, we also return EFI_SECURITY_VIOLATION
> but the image header and sections are not loaded.
>
> This difference in behavior does not look right. Handle the no TPM case
> like any other security violation and load the image header and sections.
>
> Fixes: f9b51dcf294d ("efi_loader: correctly handle no tpm device error")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

I think you can skip the fixes tag. It's an improvement, but it
doesn't fix an actual bug
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>  lib/efi_loader/efi_image_loader.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> index f9a2d2df405..a03866c2907 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -1004,9 +1004,8 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
>                  * this is not expected.
>                  */
>                 log_err("PE image measurement failed, no tpm device found\n");
> -               goto err;
> +               handle->auth_status = EFI_IMAGE_AUTH_FAILED;
>         }
> -
>  #endif
>
>         /* Copy PE headers */
> --
> 2.55.0
>
