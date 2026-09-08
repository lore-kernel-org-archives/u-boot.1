Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF16DC79F99
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 07:08:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DBD240497;
	Tue,  8 Sep 2026 07:08:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MuVb0g-JZy78; Tue,  8 Sep 2026 07:08:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 903B8404C0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788851309;
	b=rH72wge9JujquYkttpIGGWzhxz2iX8odlCPHhTDk5lMY88ZtrSEJ0ULtv2ZxGsGg2LMX
	 EfgWuoPJRWoePJr+rNixEKYE3y9h+OYHupIqGTgJH1cIRrFILld+2cDX3m43k2hQj/Nk3
	 YOWbWbCOWsyphgyEmEj60COhPk6T1Jlmp0dSuUhSdj5VtAtB0kmnKvm6/2w74tsCGY0/k
	 VYCvlabv5H4eau4B1YrOVyXmlMfTi2P1y6Oc4yIjjAKxAjgdBNoefsGcTZHBnYs+YUpvC
	 1o2VTJV7Tl0Rjnrp4cuumPpT9hfUp/bmR3eZRXSktIxFL+vKAN2tSDRAx/1Wa1Bro4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788851309;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:To:Cc:Subject:
	 From:X-Mailer:References:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gvQ0Xd/PzYxhR3Coc3zTt3knqupX0wqgDjci2jAJNso=;
	b=EMB7ExXyw2YmmClT80PD8zwrmkWgQKxUXMVIxWAoXITVH7+rzT08X+7P/3AfiWAutl+/
	 MA+rdNUymFnZwAxglil0ENcNHqII8tA5xcrN5pL4dyVm7k0SYCxNKWOTAHehf83AXYg9w
	 m6UQ7zM5ai3k6hcDqTtnrqKl1KCoFnJiUpb9/sHzXkguVs4Q4ysimDdwstXmwgRv6uHlY
	 ivgSOQjGkuMmSFHnpl4e48id1/wvXk6nPMuuCjBrWwjwzVUaynxFt9SurDU69I1CS/cpB
	 Z3vM+4ePg48gENeIvn1uYfEehTSTmujnGY7ajWeut2Tgt/aJj+tgMEM9kvkfWPuGFtg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788851309;
	bh=gvQ0Xd/PzYxhR3Coc3zTt3knqupX0wqgDjci2jAJNso=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BMojJUXkgc+i7H2P/BV9nqcC0FSrQRYpe2lVAUZIwzaig6UEBjGjgkjFpUHZ/G+7g
	 AJXZYWx8/nuDNdKzPAZbYeaLQ5BuTKgIf4S81V0NWr3bGoMhOBA+2pf/+fs9cQ+L4C
	 7HpwsubDRmZroHexSd2StnQUQtAlUVNMgyiFVmvAH+U4AzOQkT1wd0r4W0+YOcFnY+
	 FTtZdl28a36W528zcOigt5E2+ZS/u1SVOda71yC60WBnMapF22kJ0Ofiofgl40A6EB
	 YivoK3o6m544jE8nliNs0rpRXCZIgSCpgbJVOVs2yiH8woxibqYP5eMbEvC4O1tJd2
	 zZjMRNpOYI1pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 903B8404C0;
	Tue,  8 Sep 2026 07:08:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B5F75230
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9343D400AB
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:08:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k4F9JX_JhYR7 for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 07:08:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6CB094005A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788851308;
 b=kewqx7FLv6fbsPAQ4CgRf+kTFsvc4GJZ5g8eT5vL2gJpULCkCUddMy9EaNoMjjcNB3uW
 xCu7CUPKbJzqHXgS/uJpo3tKJwR9YtL6Apyn6LEqzyH1ItM6ZnjtCmHfPkX8K+9GyaTWq
 rB9ky0E7zqWZs8pjbEFvh37DduIrWM9fKNfNuJ06sBZWWViFZdXxnE+KwGnOoCRu96b+1
 Xb+h7RiFv63ZHMwYXwJHCgAuKmOkSJXhdjaZigpbefSqb10D38FkKBOAfMf80XfoDA23i
 NTqQNZcCz4eAEAvqgKlpgJiJFDqyxFwluXxSAz+LOquS23hk9w4aXXbqJqVEAWs6t8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788851308;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
 To:Cc:Subject:From:X-Mailer:References:In-Reply-To;
 bh=gvQ0Xd/PzYxhR3Coc3zTt3knqupX0wqgDjci2jAJNso=;
 b=X73IZZDouRfkGRTb36DKWDTatiMuzIrjl024PbnBA7kB1ObiJDhHFsMtlJSVKkTbbQVX
 9uAD7OBW5U4t/k/bvQn+KT5PHpntdBnf1pQAWXD4rLG+bw/Ek+k/J8IYg69O7agiC9i3V
 Q58upD22WEH1+uzclbQ8nGLELi9/IrG1LQe2ib+9S094AH51Pntl1avonmgwzHG/bYySR
 XWCj1Fycf+Sj66ZlUVfCRMdinDuJY+r+k5+85/ojFqHtYVqvSiL8u8TDXdITV8OilyADm
 wjFWfTBFa2Fl8SwPeA3R/hMNrbQLAuHpbBCm3Q0+CEJYkR2u986g4M28lWEYckH8FuQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=YqUDDlSL; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=YqUDDlSL
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6CB094005A
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 07:08:26 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49b965570d7so49616105e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 00:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788851305; x=1789456105;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gvQ0Xd/PzYxhR3Coc3zTt3knqupX0wqgDjci2jAJNso=;
 b=YqUDDlSLvhfAWMmeCmAagcf4PVuNI2cZCZ8xmGMyUQnhu/LSJwS6eQLp9aYmUYFVhp
 DwW2VGrQJy8s+PcWMx2+MqTuGWwXWt/y1GkzZTrzUVHncPRl62NybGeLcTjEJ0YbK13t
 cTVpAg5mEbGK5vRpRaq/H8PtyarL/xaLvqhANEUKDD554GrK2IRyPo9PKbvZWs6Wbdw9
 cb/f2jJWKrdOnowIO1OwOylz336uef784ZVGQsZ1tK2oZt5cFtuknLKUI3prErx/tONQ
 J8efkeHh5wQLORqCeFIU+tbAhMUb8gR9vfLSh/jb04t2OjZVcYl6Qg5u1igstINvjxig
 Q53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788851305; x=1789456105;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gvQ0Xd/PzYxhR3Coc3zTt3knqupX0wqgDjci2jAJNso=;
 b=bKVz+i65KGPapKgv/I5AW7XnAAfZWsXK/z3sLoCykweCW8zlFd+vdIgJY+e8r99Dk3
 YUjOGEzKXYs8Xtr3Zv2gYe1d9KdNTzEmpccTsXuYEEkJT0DAi1sbnh/dCjwY086pYg4j
 tW5VV6vfU/PZ6PSnk2jz1KdhauqqtGZmeYvQfYphnl6KCYRaQkeH/Scdj23bA2lf/8GO
 ozKZZHTT+yvkbWeNb6V4oQPiJwP70Qa4uNrdkMELStYilbmjdQN9kjkRjdSXlgc8vjvv
 dVrTARxPs1ezPoBn3zyYhpfKjlpRwmfAypzDtbF8TlClX4XhaZVIjcpUlYWuUih73zkG
 qhWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByYlI3GzMhqsWzttjb9ruScgkSV+MI+wayMddD6OlnBSntn3fpKMoAhoM1jkjbjQgOmPuPbdUA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lRu4xt7xg/D81sxuIerxINxqKLH2GqpAByHvS7CA738b5GUEn+
 QjoFmNVgDx79HLwC+R9JCxiUdY3DB6MFhsWUUfpfVEnfk3HrBapwtXveWDSmbiGUg2w=
X-Gm-Gg: AYBFou0PLQvKDVeV9PToAXb/UGU5N1xRhNzEMtds4TW+VC1cZGXmOpa9xHqNlor8Uhh
 q0Kb3vIJOMlXjQQnOA8QTG2TF0ksZccHIt0Uwa3dquMeeBczoVrzgyyqI0kNv0W7esRAL92+xiR
 N/jPrO5bhHHdr/2UTs8amDhHocZtURgUR0oD01o3c7rTG1Sg2sjBHK6Z2nwKeultNyrDn93JxDQ
 L6UwPAqgoR9gCDqE6mr0d6qfc7uTJTebiOkmAmcKrMNRYJZGR0czQqr4j6bq5iA/RisqaTiSuKt
 IzOoSZhbOLCfU9ZCdqUv0nbNdE3Y60NyEaw4ypqEEmkXZrl4tYqXq/3gol9hZ00Nflctp0Gz0Mj
 slpv+FFFuTVuIEM7mGWIm3a7pxCI7S2cdgeeqvemqmxfek0lkWa9FDk96rK0UDaJmGvMvcQtpbJ
 Ad1+Qxs38KifzD+Ljomgl/sRrKbSUNJ/d9QqvkUuJ4uDacU2wDQgrNG0g24gwnJEHNvutFb7U+i
 YF/MEa0ml5SxmiT6bi8itCacjkj7jX7tkLxDwaImSNhv9HxhY/J+UDD9WHiBAnMuljK0drtqu+c
 8f4ucaLEFJrwd9HuU0rlWJ+4x3qKq+EcKh90TOHyVQaPAaPEmvt7wZa7iUWJR0v2wV+CS8Udzhw
 VlGWhsTTGoLVZ6hllyFwNcnG9OPW3uGVdZNba2+ELYC+r50ibbqoZU+r3pc0z4Iv/8GXFgpTkfw
 0yd3EAswvFVYfUrzHKMEeKGX78tHS6YNESqJsskOJqjdSRQKWVE8ifaYpZ16syLJUeswatVk0wn
 VcYN/jfaLRRAkgU/Qmi/trcTlYP9dFFnKYJAjbMJSMc95L+lSezUJW0fZufZ6Ee3hxGqA==
X-Received: by 2002:a05:600c:c4a7:b0:49c:df2b:15fc with SMTP id
 5b1f17b1804b1-49cf823d0dcmr283835845e9.8.1788851304498; 
 Tue, 08 Sep 2026 00:08:24 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee6158e9sm456794835e9.12.2026.09.08.00.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 00:08:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Sep 2026 10:08:22 +0300
Message-Id: <DL9QV3I7AB7A.3R0777LUCF562@linaro.org>
To: "Jan Kiszka" <jan.kiszka@siemens.com>, "U-Boot Mailing List"
 <u-boot@lists.u-boot-project.org>
Cc: "Jens Wiklander" <jens.wiklander@oss.qualcomm.com>, "Sai Sree Kartheek
 Adivi" <s-adivi@ti.com>, "Alexander Heinisch"
 <alexander.heinisch@siemens.com>, "Tanmay Kathpalia"
 <tanmay.kathpalia@altera.com>
Subject: Re: [PATCH v2 1/5] tee: optee: Factor out service enumeration and
 binding functions
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.17.0
References: <cover.1787514446.git.jan.kiszka@siemens.com>
 <70c9bcf676e253ed8c86699237c74e41c86eb34a.1787514446.git.jan.kiszka@siemens.com>
In-Reply-To: <70c9bcf676e253ed8c86699237c74e41c86eb34a.1787514446.git.jan.kiszka@siemens.com>
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

Hi Jan


On Sun Aug 23, 2026 at 10:47 PM EEST, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This already avoids code duplication between the different enumeration
> commands. It will furthermore allow to implement a third one for
> services with RPMB needs.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/tee/optee/core.c          | 33 +++++++++++++++++--------------
>  drivers/tee/optee/optee_private.h |  3 +++
>  2 files changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 4d67c948ec1..2871760a7b7 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -156,7 +156,7 @@ static int enum_services(struct udevice *dev, struct =
tee_shm **shm, size_t *coun
>  	return ret;
>  }
>
> -static int open_enum_session(struct udevice *dev, u32 *tee_sess)
> +int optee_open_enum_session(struct udevice *dev, u32 *tee_sess)
>  {
>  	const struct tee_optee_ta_uuid pta_uuid =3D PTA_DEVICE_ENUM;
>  	struct tee_open_session_arg arg =3D { };
> @@ -176,31 +176,34 @@ static int open_enum_session(struct udevice *dev, u=
32 *tee_sess)
>  	return 0;
>  }
>
> -static int bind_service_drivers(struct udevice *dev)
> +int optee_bind_services(struct udevice *dev, u32 tee_sess,
> +			unsigned int pta_cmd)
>  {
>  	struct tee_shm *service_list =3D NULL;
>  	size_t service_count;
> -	u32 tee_sess;
> -	int ret, ret2;
> -
> -	ret =3D open_enum_session(dev, &tee_sess);
> -	if (ret)
> -		return ret;
> +	int ret;
>
>  	ret =3D enum_services(dev, &service_list, &service_count, tee_sess,
> -			    PTA_CMD_GET_DEVICES);
> +			    pta_cmd);
>  	if (!ret && service_count)
>  		ret =3D bind_service_list(dev, service_list, service_count);
>
>  	tee_shm_free(service_list);
> -	service_list =3D NULL;
>
> -	ret2 =3D enum_services(dev, &service_list, &service_count, tee_sess,
> -			     PTA_CMD_GET_DEVICES_SUPP);
> -	if (!ret2 && service_count)
> -		ret2 =3D bind_service_list(dev, service_list, service_count);
> +	return ret;
> +}
> +
> +static int bind_service_drivers(struct udevice *dev)
> +{
> +	u32 tee_sess;
> +	int ret, ret2;
>
> -	tee_shm_free(service_list);
> +	ret =3D optee_open_enum_session(dev, &tee_sess);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES);

Any reason we aren't exiting immediately here?

> +	ret2 =3D optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES_SUPP);
>
>  	tee_close_session(dev, tee_sess);
>
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_=
private.h
> index 1f07a27ee4b..25b6b3c3218 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -27,6 +27,9 @@ struct optee_msg_arg;
>
>  void optee_suppl_cmd(struct udevice *dev, struct tee_shm *shm_arg,
>  		     void **page_list);
> +int optee_open_enum_session(struct udevice *dev, u32 *tee_sess);
> +int optee_bind_services(struct udevice *dev, u32 tee_sess,
> +			unsigned int pta_cmd);
>
>  #ifdef CONFIG_SUPPORT_EMMC_RPMB
>  /**

Cheers
/Ilias
