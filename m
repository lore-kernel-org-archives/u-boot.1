Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35A6D5E38F
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 09:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05D0D88E1C;
	Sun, 10 Nov 2024 10:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lJC1+7/n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CB9F892E8; Sun, 10 Nov 2024 10:02:13 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8D6888D7E
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 10:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e3fca72a41so2883809a91.1
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 01:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731229329; x=1731834129; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hM7qUWAbH3wRnRzcTQFo/hoeuWmE8pI6I+NWhS9FLPg=;
 b=lJC1+7/n9X4m3bJUezarAvLeDjo043n9YpfvsLv6tvZaOigR9XcwHZC5dCrciv+rBg
 Pe572al3B8+zM5BJuEOm2hCdftTAHsDFLSuVg1p55XmsljcriKcCpq+Mt22BElqtBBuW
 IL/4KSq2xUkk0MxcrocuonmYWzXu36vf3sXwRtorOfWmbZcDdox/PpA8vdzPVHQXQIE9
 b8aqaeDf05v8YBEr5AjJ3jfvtKc/asw02eNRIeDen+UVdYcvhrhcCOeL+/9N/BF+t1gD
 qVHSusHO2bVS6NDeSAtteziCjoqDQIyFPyfsrGVWy4sA9XVuRUqiKfvMNiu2PJVsaKTZ
 Go4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731229329; x=1731834129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hM7qUWAbH3wRnRzcTQFo/hoeuWmE8pI6I+NWhS9FLPg=;
 b=qDUcg+NVVvRfH0H4jH+GfOyY5Nm/1sL1pQcY9GAj0LoO+s3B0mm03nGoyVkcrYg1BG
 RlFYZXVChCW71nVjDRxDYtQywYDigtVKkB+sypi+VLsWjNoqEGrKzzCx62EmS+saqKgj
 nSSOX7nkQ1dw0p2VorGRnO6f0pIma6RHPZyIhKmJ+1QYbURbJB6p2dTuGyOKUME/PyWG
 E3frjydE4vJNBs4fA2ShhcFMRFe0hhAXwMMEVNBQt3VA7dYgeu0s3zM2yTfz8PJOChUV
 c/OpskRuqf9WR7I+OvGIktw4VHGoFUnfo1l8BeE3nCOwfmh5j1c7ftHJZGIYPKTq3UQE
 WJIw==
X-Gm-Message-State: AOJu0YzRb11JSmb282N7DqgjKEvEs+YCphc2Y7hpGuezEY4RiB9xTnKg
 NCYe0WNd/FwCS/XHOf/KPj+eBzvnYI6m318XILgkRhso5NjyJn9qMXMKu3iruYrzD/VVmea7I3z
 4rv1ACz4abmPj+cpEAJBTqPpWf7P3IbJfrnJyYw==
X-Google-Smtp-Source: AGHT+IFKdr9PCvJ+OBk1ekBG/tqYTyQJFzi4ztG3OJa/B6yJz6J173nFj7l3A6OGM/fOzrAhHyWv+WtXM7774g+Tgw0=
X-Received: by 2002:a17:90b:5303:b0:2db:2939:d9c0 with SMTP id
 98e67ed59e1d1-2e9b166b606mr12644597a91.2.1731229329062; Sun, 10 Nov 2024
 01:02:09 -0800 (PST)
MIME-Version: 1.0
References: <20241108133850.431075-1-adrianox@gmail.com>
 <20241108133850.431075-4-adrianox@gmail.com>
In-Reply-To: <20241108133850.431075-4-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 10 Nov 2024 11:01:32 +0200
Message-ID: <CAC_iWj+v-tk-8+MgkBiFKnrhTh4S=mtkQRRWKm=MaQxdEN8Ccg@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] efi_loader: device_path: add definition of
 DEVICE_PATH_SUB_TYPE_MSG_IPV4
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Adriano


On Fri, 8 Nov 2024 at 15:39, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Add definition for DEVICE_PATH_SUB_TYPE_MSG_IPV4 device path
> subtype.
>
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> ---
>  include/efi_api.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/include/efi_api.h b/include/efi_api.h
> index f07d074f93..c76519a20a 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -616,6 +616,7 @@ struct efi_device_path_acpi_path {
>  #  define DEVICE_PATH_SUB_TYPE_MSG_SCSI                0x02
>  #  define DEVICE_PATH_SUB_TYPE_MSG_USB         0x05
>  #  define DEVICE_PATH_SUB_TYPE_MSG_MAC_ADDR    0x0b
> +#  define DEVICE_PATH_SUB_TYPE_MSG_IPV4                0x0c
>  #  define DEVICE_PATH_SUB_TYPE_MSG_UART                0x0e
>  #  define DEVICE_PATH_SUB_TYPE_MSG_USB_CLASS   0x0f
>  #  define DEVICE_PATH_SUB_TYPE_MSG_USB_WWI     0x10
> @@ -691,6 +692,22 @@ struct efi_device_path_uri {
>         u8 uri[];
>  } __packed;
>
> +struct efi_ipv4_address {
> +       u8 ip_addr[4];
> +} __attribute__((aligned(4)));

Is the alignment required by the spec?

> +
> +struct efi_device_path_ipv4 {
> +       struct efi_device_path dp;
> +       struct efi_ipv4_address local_ip_address;
> +       struct efi_ipv4_address remote_ip_address;

These are aligned members in a packed struct which might cause
alignment warnings.
Commit 7dfab398558 explains why.

> +       u16 local_port;
> +       u16 remote_port;
> +       u16 protocol;
> +       u8 static_ip_address;
> +       struct efi_ipv4_address gateway_ip_address;
> +       struct efi_ipv4_address subnet_mask;
> +} __packed;
> +
>  #define DEVICE_PATH_TYPE_MEDIA_DEVICE          0x04
>  #  define DEVICE_PATH_SUB_TYPE_HARD_DRIVE_PATH 0x01
>  #  define DEVICE_PATH_SUB_TYPE_CDROM_PATH      0x02
> --
> 2.43.0
>

Thanks
/Ilias
