Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD320C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 15:46:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6157E6076A;
	Wed, 26 Aug 2026 15:46:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nafau-xAaBku; Wed, 26 Aug 2026 15:46:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787759170;
	bh=aDeMuMd3Rxg/nIOR7ZBRQqct7V7FraKMlbU7X6bePqs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K6wYXVoJ4H0L4CuHDoPoFEhtbr2xu+ZDDAlYZOSYBRDl0O7YshaAjA7DgrPDpCHxk
	 sUW/8by/kVbVT9Au10eLtqSbBvyjM0mlMmMQ621TZElB9Z8/JBGWIN3F2sE+lkHlqq
	 /5d57ZWKM+yMRW5jP27MLeiK9Gi+29M5afSdDnedCdniu5JLGMVTmWVGqKxswVqE9f
	 ZwNVIOoZ8mugchNpCroKzL18dSGw7vpnkzPR26RcP/yw20lKYQYPfibjSNnVKlsvFL
	 UF9mnOSwuPlAYRYb/hwJr+8Nd+yiuAu8JukvZXmUnWF8WAugptOt6crsaOeWn7Q1ux
	 9nNjmgIpwWJvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E8436067F;
	Wed, 26 Aug 2026 15:46:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FA4D323
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 15:46:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D72180A6D
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 15:46:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HrzxvHWmL_Lv for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 15:46:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2c; helo=mail-vk1-xa2c.google.com;
 envelope-from=raymondmaoca@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Ru1jZySK
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7946B80A67
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 15:46:08 +0000 (UTC)
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-5c664b8c3f3so526302e0c.0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:46:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787759167; cv=none;
 d=google.com; s=arc-20260327;
 b=sNbQoci36YY68AvXpAup0zgaJmmOlzMp5q/7PBsO1KFY9Om0EsX48y5yHgPE4CTXF+
 gk6ZX5MTVnbHLA7aFS/0qLj9gQ474RHPwy8bjtRW3Me1kLJwe4wiPHLUttzFcVgiTvlA
 Lrk8lWwiWdkZkWVaTfj5/AzQ4PTC1nysP7Lhq5BvWcHqmT858gkj6RecKvEAKQ6vSfU2
 Z3hTB8I0YEA6ego9kIUSsJzfKHJyLb3hPiXPRP87pjYU4XOsqRbCX3TlGLbbvyxIFKR4
 R0KrsthTzl9SxFAi+1ypTJyg5IweT0CE3AOw3nVxM9tuUUoqs4qoPzVxj0AVMxIanHC+
 AYTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aDeMuMd3Rxg/nIOR7ZBRQqct7V7FraKMlbU7X6bePqs=;
 fh=z6gOBDA0oG3gqdldNDa/8dLUEkBroaEh60/RB7F95kc=;
 b=kXW/yiCgVcGWVQK7vjGj9D4VMghPX0cKkLte6Bpvwh/bj/hJRKrcR+631Y4Ycreeu/
 F1+cmuyk/KGZGmriQqVksnw5EMLmuP1i1h8R/1EctROI4zEQVL4RrMdq6bwWx+QJq9+m
 YnOJemD1tLLampEuTqOi2VcSpWy7Afgf/qa3BflRXGmqgD41bP1CpLPPrPl+3mTmbIcE
 pr+No0/uglTDdyrXN4xBLRblP37gzoZ46/0hq+kJQaOHr7AGcf1PfdA5rmXt0SvI7SCf
 nwQv07cUu2qn3X3Dr5CBu2C8UQ9FmYJI09zWCdGYcEuoxF+Eg+AboAVKgNF+Ge1qWm7t
 4/9Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787759167; x=1788363967;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aDeMuMd3Rxg/nIOR7ZBRQqct7V7FraKMlbU7X6bePqs=;
 b=Ru1jZySKYhrkGdfIcRJfexxAtW9Rw6TeS4aVxWxMIFPPcsDF17AGYLM/dsEkTN8CDz
 iaxfY9PkTvsIX57Mx2gK0Bnh13CGbEItp5eK6yJN73B7pDQ3JxTSdjxfR+sXCepFzxXa
 0mAYfGjymiA5xisz1uLxIkkqvB5fr3J3g8i5rK70HBcS3rhBmxIoyMTaUqrDnQr7ScP4
 +LCP2I9+r6eYwuPKNSoCLhNV3VCYt0w0rA6iw6jLCrOM3XHMU//L369ybXLOfyqM+VZ1
 xgQ/76vqzBackHUUhRQXeYMr45dw8gBZ3mxxkwzoBgtyiPxZVXF8j4xfEA0Ji6sTvJyO
 6NOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787759167; x=1788363967;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aDeMuMd3Rxg/nIOR7ZBRQqct7V7FraKMlbU7X6bePqs=;
 b=XA8hTTyaIvZtn5XgdBbWKMTHAGhB5nkmdKO0XWWEMOvjAr7lELi43hXlDggWYi5pRF
 wm5dR7yMgdZM7Ub6x/fdSPDZfUN4QNtEHkQiyoYkJT0Nt4WGUSKNid6t/tANlRWKV8QY
 ytf6FIIQaHChVCK9qGnV88cqISGeG7o7pGfWfNP/NmYcXmrWPOWOGzSQnF3MoeWZk63X
 czhH4fX8vb8mC+91Kxn+we10gqIaZ6UEII7aOafB3Spx1lnUVKB8EI3TOV6SpX6JExQk
 XHzh/kRgMG1ojr8BK5WE47XoW42Rkx71v/2Ur/Z1/Pq9+QTzJs+Pt8JRKKyoToplFN4T
 6/Og==
X-Gm-Message-State: AFuF++lURGyZgVFGXaLFTyltR+zMDu8jVOU9ML71syat17ypXkknc/uO
 xDt4NNQLP+D+bDm74pJQCnwVlqnPcspO3c5tLDYf7QwaPJXXxd7Oj+ed+Orcx51MNv+IPgyf8gd
 zqQ/Y3Z/6B9MqWQQYZ1yNjPgAw4TSPuU=
X-Gm-Gg: AR+sD13jQeQxELv1kVVF6hcfDyKB558VVpHWI30jocwQuLb5RMDDHcKa7USx+CxOOrQ
 7PlMde5voojnLhAu1zWGY9zy26a8suXiAsSzLZ50mfTRk89hLR7gQFq1MECTzwgItojA/OXFZu1
 mOPGmA9BtL/lJQkad9n+lbzDibCiGVGwxAcKUcSDHwKUL3p4rRuwbudMPPH20hXpHXH3pYc1l3r
 x156erimqvMTTYB78KuqtgI2zZTeOK2PB5/kRoSGEIhGtzlvU5+OoZFKbbR7lmp8d5tH7XFb6Ya
 U174HOO2DAkgBiFah2FH73rCC8Oud/TJ83b9vxvr5gQSexo=
X-Received: by 2002:a05:6122:221c:b0:5bd:fc23:c9d1 with SMTP id
 71dfb90a1353d-5c65c1bc42emr2943450e0c.6.1787759165372; Wed, 26 Aug 2026
 08:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260708013019.288985-1-trini@konsulko.com>
 <20260824194814.555634-1-trini@konsulko.com>
 <20260824194814.555634-2-trini@konsulko.com>
In-Reply-To: <20260824194814.555634-2-trini@konsulko.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 26 Aug 2026 11:45:53 -0400
X-Gm-Features: AcwNN1WKz4TKXprVKRBlYAzu97zDIUsCNUxK3X7d9TW_XA-2HWKmqrDVkD-uqJA
Message-ID: <CAMDkj5yLgp-niN-+n8PiKsgKmoPm6uffJf-1AouMOceg1qwFUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lib/fdtdec.c: Disallow overriding
 BLOBLIST_PASSAGE_MANDATORY
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Tom,

On Mon, Aug 24, 2026 at 3:48=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> When we have CONFIG_BLOBLIST_PASSAGE_MANDATORY enabled, we don't allow
> the device tree address to be overridden. However, in fdtdec_setup() we
> had been allowing for various cases of not having found the device tree
> in the bloblist, or overriding it, to be possible. Add a check after the
> bloblist check such that if we have enabled BLOBLIST_PASSAGE_MANDATORY
> we return an error at that point.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v2:
> - Based on Raymond's feedback to v1, look harder at this code again and
>   introduce a single check earlier on to cause fdtdec_setup to bail out
>   in the case of BLOBLIST_PASSAGE_MANDATORY and not found.
>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Raymond Mao <raymondmaoca@gmail.com>
> ---
>  lib/fdtdec.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>

Acked-by: Raymond Mao <raymondmaoca@gmail.com>

Regards,
Raymond

> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index b91e067106dd..d25535bf36cf 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1845,6 +1845,13 @@ int fdtdec_setup(void)
>                 }
>         }
>
> +       /*
> +        * If we have bloblist being required to pass the FDT and we reac=
h this
> +        * point, we have a problem and must exit.
> +        */
> +       if (IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY))
> +               return ret;
> +
>         /* Otherwise, the devicetree is typically appended to U-Boot */
>         if (ret) {
>                 if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
> --
> 2.43.0
>
