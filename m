Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44876C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA10384C12;
	Wed,  1 Jul 2026 13:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GtnKvNqQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE13484C17; Wed,  1 Jul 2026 13:59:24 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF36584B62
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6974a6e54dbso1015778a12.2
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:59:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782907162; cv=none;
 d=google.com; s=arc-20260327;
 b=f9DYLkjQgUshjYxey//W45Bddbnj+LBWKx8SujszycXuzAHy5pyiiZQ45ChgR9Rl1U
 2mGl140Lnph/bwLlLi95S5WPMuHuFnxoKBFumkEmSXoRBW4gatvd7OioTdTrMLLQvNp+
 CmeE0OplInVeY1tG7K8PquyrG//sYNWiPZ9Yy3EbmmUWaAy/IkUPcN3F/vfSKnfGf4CO
 3fa+g5Q4D8J7CgRzkOIZFsUH6jMrHiHuHqeEy2mm02/2mozNvLFR444067eNclx0ctOy
 9aIDkWwbHrU7fGrsIPfXtcwgLvwvzO100UgmLXPqm+8cUu8JYiIChcZ37TqYmFl9MlXS
 kUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=X2F1IkxFcG5N+SqqXPQYeYN37nJa7O/75t79dYfAwg8=;
 fh=wY6pZ5g3GH+buS5Nnunm18IaGfl/ZGqUCnSgG0Ho+rM=;
 b=LaIY9cpLF4NTU4uf32afYlBU+ECHS614UvfvuZib/0r0IirkwzNvLNDx0G6PbA+D81
 d6QNDNjLBIbXTovGc34FaRN0/61MPyMJA2aU3jCGZpE/38OJRZrH7XPoKZovi9jywx69
 alr/taX7FpQ7/v6KCSIeSG+4jvTTOKbTaH9bzgKP53ZgK6vRakPz0QivQUocl4D7D6c/
 C+O5LdzzMLBGoXRIM/U3mWt88XDZNp/kqnkecFo4nkH8bce5Zi+tywBPJHNTvvZ0JQTi
 mdlmu5Z7zON2uPBG3jLRny/4Dy3plYX9oGOWLidNMEL5uCUamw+//UtIm81ZWkKfltsi
 GRLQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782907162; x=1783511962; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X2F1IkxFcG5N+SqqXPQYeYN37nJa7O/75t79dYfAwg8=;
 b=GtnKvNqQxjK2zvKpl4TzGj+PJqnuHxWAESTWwT8XLDuFiSJL+21AX9sTY6WomqePlH
 dsEI+68c3HsGuQCoi7J2CRYOgkpsbFwZYYlv6b4zX9Xq5igYRRT5pw9MObANjmvFQMMK
 LEV4FyfMFD51cVS0KfnPtVb30NDKwyxBeJg6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782907162; x=1783511962;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2F1IkxFcG5N+SqqXPQYeYN37nJa7O/75t79dYfAwg8=;
 b=QX3ZuCrm/xA4f8Jdvarjsr71eswV3x3p0PgpKC53OSZMEMOQFT+gB3B30MBk0raPM/
 DpM8APxNOIAT5sKIF7N8WCuExMA078hLWDcTgFRoqHkNOKlo+Mgx7li6H+jjICpViBhO
 /hepL/WDvWMTibMQWlkCfFTbOHJ6LDpsLNNNKtB7wIZOfpyKTq+a7UpHyNOdDaWRSfsM
 tbF/JulBr5GZIq1yCUmXOi3Ot1yBcaBiwPlEmT1YkwgfmgHPwMkYGaAua/eXurQb0aij
 tS6kAsUFcCv/F4m7darmm5Lzpbxc+qem5cbaV2xNcDvXehyvIHQVwYeKx+1765Co9oin
 d1mA==
X-Forwarded-Encrypted: i=1;
 AHgh+RreaS/+wAN9M6JisM3a1kOLb5/VF599XDja8slaCwCoZ4RliJ0sT8f9DqF1ldpD0qNBFz7weB4=@lists.denx.de
X-Gm-Message-State: AOJu0Yxx9jht28EJmynS1TT8ynzG3lR7oyXE2iCXL9dFvFiQhZ/vZ0uX
 DEjE5NoC3x/DWvfYzTXjoO27gT0UaI+imHviwEphqGS46QQewQnpNBq1lu0F8FXRmSqEKo3sN9S
 svh9/A6E8eB2QLr7Sbsv9W26mWVxy9IfMSgw5zvpJ
X-Gm-Gg: AfdE7cmAD0zOTzdG/FHXLHQkL0kwZ1Kcm3llwTL+MquxJMQb5sPiaIjl6qN3yZJ8vVc
 638ybxs7Qf+eguwXA8prZ+8FpdVNFmfv4ySpag5XUjRxx5nJQ+vLILD68EXp4rD823HWK14WnSr
 yl9JL9M9I6iKeQs8WiP/Kf84qROlbPzQXWtvh97NmoMUUZHUtneg896Hm2KK5cgK1MYeKAl6QhA
 stw+NanYRl8oDPD4m3ictw2uZf71bTBkiNl/vVeg+tSjcuySTSBvfxzV7CXg5UGbslPGk9oPA==
X-Received: by 2002:aa7:cd46:0:b0:698:410b:1020 with SMTP id
 4fb4d7f45d1cf-698a2c7e49cmr95753a12.18.1782907162383; Wed, 01 Jul 2026
 04:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
 <20260628082810.175862-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260628082810.175862-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Jul 2026 12:59:08 +0100
X-Gm-Features: AVVi8CcJTpQ-m4MgM9AfBRzCfxW7UfRiMgLlcd4CfZrlsusUT7zTzjtQ0JLK90g
Message-ID: <CAFLszTg0C6cQDVWYbSPRJxjCwFhH3oa4yCPb8tJa4h7Akd=aXA@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] efi_loader: use pointers in efi_acpi_register()
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.denx.de
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

Hi Heinrich,

On 2026-06-28T08:27:58, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_loader: use pointers in efi_acpi_register()
>
> Both efi_add_memory_map() and efi_install_configuration_table() expect
> pointers and not virtual sandbox addresses.
>
> We need to convert the virtual sandbox addresses in efi_acpi_register() to
> pointers in memory before using them.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> lib/efi_loader/efi_acpi.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)

I think you missed a few things from the v2 review.

Regards,
Simon
