Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37BC10F995A
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 16:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4549C8412A;
	Wed,  8 Apr 2026 18:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V0+XgUff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C45A284106; Wed,  8 Apr 2026 16:16:45 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94C93840AB
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 16:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fra.schnyder@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso58148765e9.1
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 07:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775657803; x=1776262603; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dMxidFxjTnRr5DHuMXBhTw/1dvkahkQ0ARSM/Lu3sWQ=;
 b=V0+XgUffkkJelHbWBYC+U+oIJOdFjqtuDIPKYOoyMLnaSHHoP0xyhbJxxElc6wrXiU
 BpXtJ195NqFZ3QiCTOBY+HkTcippvMGGPzDP9E0wOwTXKP7bWW0qquKAVqiGzfQwy+ag
 Za8p7RztcNwQ/YvqWICoA9FWFkxB00Rtq9oaK2q9beK+eZrwONjSn7Lir1SzZN7sreyt
 KFCL22aN/xpG9i1haE/zXv65s7k40tfep5jdqAASqxVYXIh8gEMc/OYqhsMPdxYl2zF/
 C6cbY/RAu6O4ZaoB/6GP656yn/fBoBluiB3BlVqgda8Jo3v7eSHlCITXCt4yqCAU7t8A
 bhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775657803; x=1776262603;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dMxidFxjTnRr5DHuMXBhTw/1dvkahkQ0ARSM/Lu3sWQ=;
 b=WKs7Q0stp8KVKzyVzoYmlhoj0dz9XDECarOuLo4+hBBOwb1Th2Fqc5dFuVuXrz/BPD
 +kSgajN46MGiEjwtZ8O+9gGKuuiN26rriOIfG/Dm79oGsMrGQ3KGlCuABjcJeOo+Wj2O
 f+v/KlGWKGio4P9iJipmwpVTbjPLZokHx4Fej1Buj9RJWQTFv4fO4y0eQL+XJZShzTpD
 t3WIOYoQw/Oae9eW181u/u+a+XPTWt0rblMrgXHbYxQHhzAwoUNzO2pwZpAShFhtzvDN
 tTUifdSu8wE5l1SL5Xt6FPE5D8R78W3yCdcCjzQ/U9lfUDNxRVpVx+F0CFhlWVXc/y3E
 AhFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDCF2DWui3fh3gwNP59hX3TuD0V4n56/y4PD6QpvqbQDSt+a0Aw/3BAThJLkyz14GD6/sPfHM=@lists.denx.de
X-Gm-Message-State: AOJu0YzNCmlAilMCziMfgbzLlx8koMOgRcaSuyfrQV53gJWS55b6Xvbp
 aZqqkm9bCHTSuqN8987TtesHnk2sa3Hymx0Y1gSMduiQc+NfOr7KR2ei
X-Gm-Gg: AeBDietg8qnwliUlZWgXn6sNW/joV61Tk55nnIFrLk9MVgkNNMTj+HUwyhbf95SA3fy
 giIJMzCLDlJb9Srh2kXaZ/t5Hjgw2bOs5y4J5tyxZW9P+4nNxOwJpwVNCUdJ8JtcKsroiLiMOG3
 9IhAP+VcRj7BdKDnu3p9xYAGDHCAXj0Jn/Jj2WBMusGIcfc1BFTTa/0nKEqHmzSK9XiTZD7eqGn
 5D8tP52B2G+KD62uO0KL7sF1kO7930JlCbGMLMCV0iPs0PlDP1Tu0PBC9750vjEQ8oWHp2+ChuH
 GwhW6dwxEiUqgXRY6odjle5PrTjuQMY1xgGzg7jQle6Cb9sySHRZ2R/XMj/o+0kRWxO0IMBWsKl
 OcDo8kuGcTbw0SoQUWiVKcr5BT5Bxe4F6l1zarOxuJaouzJ3PNfJsZItYa206TLdgGV9abNOJMp
 efqZk6AApXAwVBs2lA6JEu4kIFcePUysluRDoYfFk5NNrSbF5R2ZT3pCbLbYEOw3TOFkO3xsl3T
 Y/QzW01Usr4EV63aFyxbCD5izyBTn3lxpWl/+kj98ExrVdbFIA1MSWM+LfCQYu17zXemaGWRQ==
X-Received: by 2002:a05:600c:37c8:b0:488:ba5f:984f with SMTP id
 5b1f17b1804b1-488ba5f98cemr126136595e9.6.1775657802779; 
 Wed, 08 Apr 2026 07:16:42 -0700 (PDT)
Received: from franzs-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488c1c5291esm187671585e9.15.2026.04.08.07.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 07:16:42 -0700 (PDT)
Date: Wed, 8 Apr 2026 16:16:41 +0200
From: Franz Schnyder <fra.schnyder@gmail.com>
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: openembedded-core@lists.openembedded.org, u-boot@lists.denx.de, 
 simon.glass@canonical.com, Francesco Dolcini <francesco@dolcini.it>
Subject: Re: EXTERNAL - Host GnuTLS now needs pkcs11 support
Message-ID: <bcq6u674sxgtmi6sdbeyrnvr5okjdcf32kqre2se2tn7nkuv4z@yfjgumhdscp2>
References: <f5ov7deig7xaovxmtx3nhewki6mudgebahghknhxodlfa3lrdh@ary63d3fodkz>
 <adX6wVUWvNrzYfuV@mt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adX6wVUWvNrzYfuV@mt.com>
X-Mailman-Approved-At: Wed, 08 Apr 2026 18:59:06 +0200
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

Hello
On Wed, Apr 08, 2026 at 08:50:41AM +0200, Wojciech Dubowik wrote:
> I could add disable compile flag in mkeficapsule if there are no objections. Sth
> like this in pkcs11 places:
> 
> +#ifndef DISABLE_PKCS11
>                 ret = gnutls_privkey_import_pkcs11_url(pkey, ctx->key_file);
> [...]
> +#else
> +               fprintf(stdout, "Pkcs11 support is disabled\n");
> +               return -1;
> +#endif
> 
I think it makes sense, given that some U-Boot users might not want to 
have pkcs11 and deal with the dependencies. 
> This way OE or possibly openwrt don't need to patch.
In any case, I've sent this patch to OE to have pkcs11 support on 
the host side if it's wanted.
https://lore.kernel.org/all/20260408130553.819420-1-fra.schnyder@gmail.com/

Kind regards

Franz
