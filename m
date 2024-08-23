Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCAFC531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 19:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3EE988914;
	Fri, 23 Aug 2024 21:42:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KycOzITC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9612988A56; Fri, 23 Aug 2024 21:42:46 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1A4A885C5
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 21:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-533496017f8so3150114e87.0
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 12:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724442164; x=1725046964; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qt2HsN7geEle6vVs5g35Jzn3nW+AoX61J9XtCJ1IoTQ=;
 b=KycOzITCpb8BhkedALpkV6iJ4PnWj3dkq0nTrwXpT77MxPv2zGy0s2+Qvi3SdKF4Ju
 V7yB9QeoMhS7px08srDZTAQxz7KSYYPKkFX7V/ibw0idA8bco6ciqqSlhM8okUgvKoMX
 evnSQ0T3gdwuFB8JYt64UoQzfvz/TnU/74ufT8/uQAfhotJePu9c0aGnHaMMbOxeCAZ/
 adTcvJha0CCatmx+VX8usmkqhWYAwxawp6KdO3OQ0K8i+cOS9HSzL9QqDMhiSYrGCCUY
 WxMdLhjiEOC6YK5E+n2HNkqlNKHkCd5beFDelQkh1Q4XHwscch4T3C2vdiK8IYkoZCNw
 2J9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724442164; x=1725046964;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qt2HsN7geEle6vVs5g35Jzn3nW+AoX61J9XtCJ1IoTQ=;
 b=UOFbfEfpj3ZmwR9CHonLiNMhMH8IDSE1Wx8N15sPF7xdnmN57ClFyVHOoLbHfndL/r
 LfQMX0R4i75zigvnpTe/N6KXgMQnvfsi8qlzoy1lj5ZqOlXDiKk6LeMqIedcekmgUbIr
 b9eG549wNADOY/JpLdoPymqQ21+OSDxsaL2ikewsezMoH4SuGIlIYeFgJa1TwPxNE5vH
 oAaghLaWfGQ0B12s8v40p2bNIzzytVvY7r48f19RRzP9bPJrNwH7tk+OzUrR0YarDAVv
 eZKXNgoFe6IF/IJS4971RV01a4g5Se/WKjC6EzriUnuKLSK8nY+hvJBFRnbfGL1sdx/r
 pCKQ==
X-Gm-Message-State: AOJu0YzQZdn8Uxnj9bzFSYc62+JHFF8cpb8rYgzApcKMJLYlVe1i+AXT
 eCRU1NjwzhF3bbkW084iiNxNhktDfrAND+YF6T+4hSz6WmB3xeAkbtjdk3crjrQVPi2M7PU6aeB
 Bbl2OXlkC/e2MW6rjNrOtKV7vjO9LKw==
X-Google-Smtp-Source: AGHT+IGB8l2otnYM8Hw46fU5sM9qy/yYameRA5dlZaERP67PMVCMAfNf7/GEByf3XRUGZeHTTRVQmXo2RlmMeyeKX9g=
X-Received: by 2002:a05:6512:3087:b0:52c:dc25:d706 with SMTP id
 2adb3069b0e04-53438868deemr2503577e87.52.1724442163682; Fri, 23 Aug 2024
 12:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240823191204.3974463-1-festevam@gmail.com>
In-Reply-To: <20240823191204.3974463-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 23 Aug 2024 16:42:32 -0300
Message-ID: <CAOMZO5BXU6PJB9SiX2nRXSy7EArVykrHHUTpgv84m6uoOoYcWQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20240823
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Aug 23, 2024 at 4:12=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Tom,
>
> Please pull from u-boot-imx/master, thanks.

I meant next, not master.

I have sent a v2 with the correct Subject and commit log.
