Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D90CA5FB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 12:38:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96B9581315;
	Thu,  1 Oct 2026 12:38:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fC2DSS4dENxY; Thu,  1 Oct 2026 12:38:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D515C8130C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790858319;
	b=e4SkUQVTX/crzuxdf9iPBb9etFU2vn9r+LDOteJ7CPclF9wEYYZnVnrE9qwlOxtOn9vC
	 It7wzMedltb1d7nmVgc9qnBLeA8C5u8VEduQ/4kMkThhuBuKqDQ1vnM+YVSN94jfdo/Cn
	 inZoY3VeyjM4Hez468XcZjeWRieWCsczMeuXiEHCBTobiw9L7h/3EoZgW6I9il0bxBr5d
	 k2xNe2PAyUX9/nFP6FNetc3hzddZ/lwIW+OLzBvNOz4Lsfb3TNudg9LoQ77aKHHxLs1ce
	 Jf/apyx7GEA7GA/xcFJnjod6p7W9eNT8cSQ+60ALGvxxOamoH1I64J3jY6ZXUghtiOQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790858319;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z9+5H90gxkp3OT6vB9EI6yRN3gYn1mc4rKhTIMRsgA4=;
	b=eiXSONllocshJioIVU4YNNF/EZxAZy7An0/x0/zwgZNGfbSKxs6vXM9k3GjnNaUPRwIO
	 Hz47KvXkgXqC2LQkxPINUIry0eMVzAk0xQcqf4HD4W4xO0KvxOB7LsmUT4cIheYNYb24o
	 5Ed6pnsNQOsugeFzqB6a5YPm3gYlMMVVL19H4XJp2JkMk9pb6n23l7YAf8RLqW7LlXDtE
	 6jGsrX1wuixBwJTEHdcckjBxajcJ/YuoToIEkF+gd+7zFhqhxeaetrG1EslicdIos39XB
	 Rtq7Q73O9/PfbY6iaMC/mSFNj7loCDByJz+KyR041o+byT/iYhmuW4Ti8Mg2LdahEZA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790858319;
	bh=z9+5H90gxkp3OT6vB9EI6yRN3gYn1mc4rKhTIMRsgA4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=haKKS8T+ap61WkTVIkopTLc4KF0jZ6BJhJBAI3m4CapUy5rbihPCyyeuNd6P9gchm
	 mnjCIpHF18czzZmTjS48Rvze6l4EvvEjZ2tCrOf9/+VPx6FYGl1iluuWJtRbLOrvsB
	 2iAqQhDSZ21obkFqHVb6Vl7LAZHIkeVn2YqacY6eGNli74f1efcs5bS1UzZ9TH3OD/
	 I/zkH0J21NT2+H7BsdvS+7WESRC3RM5OZOFf5gkzHR7m766rBUB1KIh36zRW8bfINs
	 6pnCN7HfwNAYUkOTsnOaHIF3y/Vp3wi5pR+qRykLw05bV24O5sYJ/hhrA1NOiUICV7
	 rvFHjyZPd+poQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D515C8130C;
	Thu,  1 Oct 2026 12:38:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 35B7F22B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 12:38:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 335F140D5C
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 12:38:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cA3Ib6vTCAaL for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 12:38:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2840540D7A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::11"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790858317;
 b=sYLn4RLgY7zkyCV3vBBtv2lsfYMeOJ/0ycczxYUFL78S1uXzgKjHd+SEYViHrQYylYwL
 H+stKFEesP45BD4F4IgFIppK0c9V5OlFPBEIY2SHfn+55XODbwFWXWGImqMk3JBNr3aaR
 emIBkr05fnKGLYo3hWhK2HEwtusYYlFIAD72wtJrk2epEwcf6BdsIiuEY1SdqhP8i0jFd
 vEwIpO2spfgIiJkuvzn1N035AHl9ApKYivAk1aH+HPJA8oz7J4IJi1/oUgBOSjvj3R825
 XVF2pgSgJpQM77FKGstPu7Pi5Gl2FAncHIXarfwLXlDl6Er3f79cKpWvU0UGS4A0GOg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790858317;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=z9+5H90gxkp3OT6vB9EI6yRN3gYn1mc4rKhTIMRsgA4=;
 b=P4hngFVoC5W1IHBYqA/vdNiCmmuDcubsjIH7UgzbhFL7/lXLPOl7vrHG7a5SxHWFfP96
 nXlwCX5hDG1WabVCPayuqxWKs4HIxX4C/TE1BOCvs8tt/SES45B66QAH847yA2p2fzeNC
 BuYWtWWWm3WGc7K1LWng+7gb7aqXaLatRB/sUPfjcHGDchsiVgvqI55h1EOLi3RK1/lok
 TAtLWdbhPORjSwxqyrFXjfQgfSpynFYPJ+6bE3sIilKUI4n097WVKXXgc1G8eoEM9EN4P
 /6epOJKy8+PgkNX7Z+/uCteRScMv/M2RPkBexLV4rkNmpYujwjNV255g9RP3LQuXW7A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=oa5plXkS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::11; helo=mail-yx2-x11.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=oa5plXkS
Received: from mail-yx2-x11.google.com (mail-yx2-x11.google.com
 [IPv6:2607:f8b0:4864:41::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2840540D7A
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 12:38:34 +0000 (UTC)
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e4ab201ebso6204689d50.3
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 05:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790858314; cv=none;
 d=google.com; s=arc-20260327;
 b=rZzSPKnnJn22EllXg6NlR60ARmErjl/oHZyfwjC4qI23oLZrUNz/v49wHxuJKQuA99
 ELSalvo9JcBXEHbX9blmJtriccyslDdCvnO68SWPZ4XGfmzBoxkdDDgNtv+H2jYPYtyh
 tvo056Pymrr+iX5ajlV/7LYbS3e5gAQA/dNgFtgCYTTd++alzrmTjU1NXGpZGD3yOUZH
 9LyxncCKw0HFR786o4SS04l06XzrZus6XGCUZ7pu22qWqRe3xuqSwLC5jZyUcF/oAYY1
 13UtQ1VWIxfPi44HCqpFiVNaVptd+B0RcJgG4a3f96VawKK/e+hudEVhCPAlj4/N8Y64
 61LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=z9+5H90gxkp3OT6vB9EI6yRN3gYn1mc4rKhTIMRsgA4=;
 fh=julnK6wBmsT4gexVqhFOuLgLd5C7wtTV0HnCjgUY7UU=;
 b=sQaJMlpKUQGVNVbVwga3lFPFW4QpznJr+tqXwFFE8dmk5xcPWFfZJvAiQE9bMOq+2V
 ywGTYTG65RdN6Njl71AgNhljrTdIHYa1KoVX7Mgj7lBZzRnN3nvIn+fzJzdLwx0x1Rwn
 gkR47DHvx7t3tf+vSsLdO6Hw+msjYZufKvs0HHTmEkw4TYwsK3KP9qaqwWAxSE2SfzjD
 qlZ7/BbXypIw48LKnJSPwAvHooP1J1KStCi7gwQ0cDrEXRTmOtOGGuo34W9hC0BEXj4C
 TNjMCMjmVMP9TGbYoIxEHvsl7NpN/0JrF9A2YE7Ay4vSC7ZBjuolahqmreK+DAwrP0q3
 DESA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790858314; x=1791463114;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z9+5H90gxkp3OT6vB9EI6yRN3gYn1mc4rKhTIMRsgA4=;
 b=oa5plXkStGChL4jjK2EHSj5nV5GX7WeRy3mbrf7kT2r/NbF8FLlA6JWXvwBv8FrUXN
 uV36rdBWJNIBWgTs6/y0FTVLZFKVmWw/qzNYAm4BGkgNL9u8Ux1IdmU6CplfBQk2nmlS
 nY/E7Z6pTkXuOrneuMWZufzEGCVWcvz5wHtsHzWxS9X9cUl9U5kKdqtx7ka2i0NzsP7X
 RHfW5vZnO+sxnKaR3ZuUkuuBRI/9NFxPULSGIJ/QMMJFCP07SYyQHXx0mSpUm9L5NnCJ
 mIEqJfhljIQWb8ZBRvh/mEglZYixZRi5CqJxZU7M4k696h7bFEznxnEWlsYShVxIkcKA
 U66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790858314; x=1791463114;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z9+5H90gxkp3OT6vB9EI6yRN3gYn1mc4rKhTIMRsgA4=;
 b=QmkODSrIs6iAiNTH4q+lx1NhOtXKDe/eOpn1kbXp7j8fsGiRDGff9QyXBvnRhv9m6B
 hGTXJjjAwPq3eIen/1/h1kVKLKWif387Iwv5cTj7pkP49rt665NHjPsLbwSlJasYR081
 /84Zo8fvre2ZI+8qVNAxtX6BwxWZWbMcbBSFer5RmfCSEQb6DjVXrErEvaUVYvqYDSdK
 oES+fz0irqELeAiN8U99UHELJsKXgXKIuIeVxQC6F2lbgOS4/XJ+GHNOSr/tlV6Yudpo
 GBZe2GqhnbasxezBvIrT/UFjD5Y707VzIy+MjFLfHWgOhNSIiEomTFfy2UfhlkZ2B724
 xflQ==
X-Gm-Message-State: AFq9FYKmGJY3yflcdJKv8NaL76kZPHaRI0m9QDd4Ivoiw1IubGDmlIMX
 OEOvfTsWJpwu3JjlEUMUWr1sEp7Gikb4FY6HT6YaUdVf+HsC04GZtqET7PHNQkBhYkPdW4fwKzM
 gryZjOvV1RAGcLjGEgYB06JfIdqdkay7Sm0hsfQIuAQ==
X-Gm-Gg: AYBFou1l4mW/JpgQHbpTT+lukDUwYmdaS9YkhVKXKWiAc8Vi9JST5NCtRPSHdgWv89Y
 7KUy6po/XSYEh6UtekMXWrpQgkRuW9+S7bNEP/bNSSef1mk/Ue/DxmP3Xdmp7enZh27XhnieJvu
 1fe0T694yTcextHqOlGowyQtAY9nsv3TV0f+1nP9JyT+r/f4Ipa0mgQrjA8MyG4cjKiC3ft/1DD
 et0fv1rediF0EAmNsM842lwRq/baH/0MXTj0BhGxGzqHc/RaoxZb8LuO+hC4hgOdSaCwRzfERQs
 yBMtv0E28EO1PM5Im4WMZqs8zLRVcZD8lcH5fPpdxgx9ql/u7jN41eXeJrKya17s5BuW7nO8jGk
 LtI2aGpF//b8+sRmv3nX7Q+rmkzkO9mk4NlmTL8hVVqln3VMO5frh+w9AdNREtA/dbNJ9SCGBZS
 0XEq7IZmxsVyiaIAKhZuRB+35I3AAAsvETqkNSaUok9x15jJbuQkUGU1GtAXTn8yMDgWhfpw3HF
 RGpzS8df1gN/mrJe9YBkGETHMM1shQwRNZD8jpXqkKavBhnTMCreXlvx1Z0SDSHX7tqruQ6xpGb
 Y+Q+qUP1BvK2EHNYzkOFRCAy2uH/SdCaiJf2vJc878KhvReHecm/xuWAVQqzT1cgUTJjTOJaOdi
 0bvqv8BtmS07dp8DCtdwssvWMRnY7z5IZGVnLUsTD2ubZ8/7n2JIzqA==
X-Received: by 2002:a05:690e:813:20b0:672:bb52:ca00 with SMTP id
 956f58d0204a3-67683465c63mr1380509d50.84.1790858313410; Thu, 01 Oct 2026
 05:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260922-authi-v1-0-e943530349bb@arm.com>
 <20260922-authi-v1-1-e943530349bb@arm.com>
In-Reply-To: <20260922-authi-v1-1-e943530349bb@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 1 Oct 2026 15:37:57 +0300
X-Gm-Features: AclHuK8Cm1HCdZPa97EzTDr_BoswiqWFyCc5ll9flhMZHfI6QPdeEhS9H53vNMQ
Message-ID: <CAC_iWjJXBgUeRPqj+C3Hd9AoQ5CYV4ZeH8P+YDHqcUX5g3WEdg@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi_loader: fix image info authentication attribute
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Udit Kumar <u-kumar1@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Tue, 22 Sept 2026 at 17:58, Vincent Stehl=C3=A9 <vincent.stehle@arm.com>=
 wrote:
>
> The GetImageInfo() function of the UEFI Firmware Management Protocol
> returns the authentication required attribute correctly in
> AttributesSetting only for the first image; fix this.
>
> Fixes: 88a2ef2720f5 ("efi_loader: Enable uefi capsule authentication")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Sughosh Ganu <sughosh.ganu@arm.com>
> ---
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_loader/efi_firmware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.=
c
> index b41969c70fd..84de95f5c23 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -364,7 +364,7 @@ static efi_status_t efi_fill_image_desc_array(
>
>                 /* Check if the capsule authentication is enabled */
>                 if (IS_ENABLED(CONFIG_EFI_CAPSULE_AUTHENTICATE))
> -                       image_info[0].attributes_setting |=3D
> +                       image_info[i].attributes_setting |=3D
>                                 IMAGE_ATTRIBUTE_AUTHENTICATION_REQUIRED;
>
>                 image_info[i].hardware_instance =3D 1;
>
> --
> 2.53.0
>
