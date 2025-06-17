Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71751C71155
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 06:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0279480C83;
	Tue, 17 Jun 2025 08:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="R6hftWa9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E02A82B0F; Tue, 17 Jun 2025 08:17:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 622E68070C
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 08:16:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fmartine@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750141017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mr9Q0L+pVXNajBtzo2/EeyYJNW4uK1TvbMqkZ3rLeTY=;
 b=R6hftWa94orDaojkFGFV7afmQunH26V8AlcvWbZ0Zp4nqJbufd9rFAeY749IXrw5yUePiC
 qDVey4ER09WwjTZshTOf84IdmAjetS9HlTsdEorJN2E5VsSuYJ4pl0cpPaFq/Ttpxqlhxd
 5PZ99mWUS46/W3N3aghHPmrJea533Hs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-g1rT5_JyNdi2VB1G83eD2Q-1; Tue, 17 Jun 2025 02:16:54 -0400
X-MC-Unique: g1rT5_JyNdi2VB1G83eD2Q-1
X-Mimecast-MFC-AGG-ID: g1rT5_JyNdi2VB1G83eD2Q_1750141013
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a3696a0d3aso1935273f8f.2
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 23:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750141013; x=1750745813;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mr9Q0L+pVXNajBtzo2/EeyYJNW4uK1TvbMqkZ3rLeTY=;
 b=lN4BAUylwAnIfIDTcGzxxWxV3vE+YYwpWgCF7AK6cQhQpO23+BnWuC6UBxUnK7QQJM
 ev2vAa9ZnSYaUNh39P/TaqL5WyyHVTTUKb2CspbB43p+RLxORsQr+tnIUrVJHz+MYAIL
 jpnGCYXlqvUogqFkeSCL5ubekudhU9b8ZQDqx8GahGTNdi6kzN9XhUCWoFBNP+oIs19V
 SMWS3u8V8HVDv6N/MaGwIDY5KJki7lxo0fzQ2fD0f8aKJgc5kCbD/YLeeF8UKghyoVxG
 U5n4OuWqrfDM94WTIMnHLTBvFTManpCRW9JyiWnoaoeFxpb+i6MRyG/Esc6mk2Ht4RDy
 95Vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEgU06Ehq0FGpzje1QPVjiEZvBq85KpvwVjIgZrFd5OCk6xSgeFwUiO5/I8NuN/Z+00sXMB/k=@lists.denx.de
X-Gm-Message-State: AOJu0YwkbIwPFezQ1wmqxH93T7JXRuzzw7zxiZjc+9XcK4lwEzkCetFp
 IMmX4S+wKKhUbGDB9ghzNL4LKJyu2N5MK1gwMTnzz62Ql/ZROM0NQLkqJGIpwVCvHTDWknbXV2o
 M30ElJdKVO0NITpcoZn5mxWwlGSwuGjYmcrO1ReDRfAgK/BNnLdQoWj0=
X-Gm-Gg: ASbGncvYUzGsvrExSmxvitCMs0QNNOJZKFeB5xxlmaVFow5PtkfrzeawDmZ9Uc3Y8lh
 DoofR1fH6hQXeR0wVOPewyd5z+D2/Bfm+t4Cd0idoqF/3aA9p7c/L0DVfaCNnFcx13UFAHqlGPa
 kejSECF0YNUGWeQHH74k/SvGdUyAp24+N2CNRZmfKZk9vl54k+aHbh9x8+0suUiTKzVOB2sm9fU
 xWQrEz9FJaiXToXtkU6gg3S+b004tZuFp74kbvG5epkLhkDL7aUVD/4Y16qmgv6uXr9I2WMiPmf
 ewMlq+cJH8vLoILh9g7wIiN2uDVAHA+u7uJ0t588l+b7OpyTAUTNzfdXYqotptHk+JGHQVql8ti
 kgogm
X-Received: by 2002:a5d:5f48:0:b0:3a4:f902:3872 with SMTP id
 ffacd0b85a97d-3a5723a3141mr8706699f8f.19.1750141012817; 
 Mon, 16 Jun 2025 23:16:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs8EGhTriRZ07n57op2XqzEmrnl7NgcFCKkOnI7p2ZD/smmLMFtZ1jLKcMCwNStE3hx8pmIw==
X-Received: by 2002:a5d:5f48:0:b0:3a4:f902:3872 with SMTP id
 ffacd0b85a97d-3a5723a3141mr8706675f8f.19.1750141012447; 
 Mon, 16 Jun 2025 23:16:52 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4533fa7a9a8sm97978585e9.23.2025.06.16.23.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 23:16:51 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Yu-Chien Peter Lin
 <peter.lin@sifive.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 u-boot@lists.denx.de, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/2] test: disable TCG test on sandbox
In-Reply-To: <20250616220917.34189-2-heinrich.schuchardt@canonical.com>
References: <20250616220917.34189-1-heinrich.schuchardt@canonical.com>
 <20250616220917.34189-2-heinrich.schuchardt@canonical.com>
Date: Tue, 17 Jun 2025 08:16:50 +0200
Message-ID: <87qzzidh9p.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fbJDsoWSGEm_1OKqQIkWDtjRP8i0sIjD8uhh0fYQ3dY_1750141013
X-Mimecast-Originator: redhat.com
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

Heinrich Schuchardt <heinrich.schuchardt@canonical.com> writes:

Hello Heinrich,

> The TPM emulation on the sandbox is incomplete.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/py/tests/test_efi_selftest.py | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

