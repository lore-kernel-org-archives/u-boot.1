Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249E4107BCE2
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 20:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCF4484358;
	Fri, 13 Mar 2026 21:55:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fWINPtc7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F34884376; Fri, 13 Mar 2026 21:55:09 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D7984358
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 21:55:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d1872504cbso2733818a34.0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 13:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773435306; x=1774040106; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D7Sh31f2qnPqj2TP3YlNPrAOOukc+BB1NkJsAlluY9w=;
 b=fWINPtc77RZ0d1gW/oAugxpwwdylJMbhUr7p2U26Q6bwN8+fdLXh2p2WpoYwUezGzY
 3VhE8YeVCvT6kU/1svI9a+PJ7rUPCLZCog6JnJ/hzE0nEk7rTWo1NTNKw4V4RTA+O9fB
 JPlslK50QFXa/o1oxyfyFlPx4r5zw1J7i0RBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773435306; x=1774040106;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D7Sh31f2qnPqj2TP3YlNPrAOOukc+BB1NkJsAlluY9w=;
 b=S2jFI9VM0z9j1Ew9vNy+lDo5yJ27I8papvQaDiyKzDbMQBf9SP8CFMiR903nj0Fsow
 gQRfLHZTht91aJVhn4eMZO1Qq1iqVQ3s7I/V7UJbLE0YTZ0BhL2e0/qVQXLzm6fv9BZp
 ep3s1THOxo2iOPtPJtxqeNjZPJ7Mp+5I996YVG4LLy2m1OcE8w3arT436/F9Gb8FEQY7
 oe/yWMVPknMt3GQf65VlQ0Ww/xTRqQVQz8ZW+0Xvyu7jko9dIloz6xjKuAX10VOFGpi8
 4QNfk+ww9jo0rqkGjE7y4OpxshH/J83UY4wPhs4qqx71AOR6oc/5b4CMbOw6ljJD/wxD
 +99A==
X-Gm-Message-State: AOJu0Yx68t/GYJ5lZyc+cv4RclN8vuug+097EZ9ubZttehL+yOwrBnnB
 seVHe6Apr0IKLwaLyxVuZRw11HmOhGIM22bBNiNHIN3E4F7D7tMG37Dfji/3ShG8iv4=
X-Gm-Gg: ATEYQzwmXtVgveq17Rt8XnyjjbaguctXZ6oIcjOPXXpBnZW13xuoGfboViTxJesolmj
 agby1lIsTs+FESehXKv4gzIlI23+GhucX+VDhbTLhwm6XFfC3ZTg2e9cip3MGPeIOUHLv/7iiy4
 LuL4aqz3KSBj+Fio6WBAyzblGWS/HQTNeGJ6XF9cckfQdwlnH9AooMIJzuZ9J3j+YPPxCu9i8P4
 mLEjeNQ04IsW9/Sf0+JcwRKTgtxQHcIia07yLa5EpZmE+I91xGMCETcrfdeyxbD1DjRApK5TB8y
 wM/PpalqL92ZYsGZb7ZYuuLtEA/9YVYr9FbgeD8VWXQFt8MEd8sqT6+6I0uFwyicPxTbgBb6mj3
 srQ085J2Gf3Vm42ZI/7ic0Mw2cL1XTdwxoYAVD6I3Mc8yCjokZTMxI2m19dX/HrKeg/9kYBUdhV
 PTyHh7ERpai2o0gfTZf/dtmNePmoP+h8IoQxddriS+S3ckrN3P8pAqkhvwM/SMeBM2Zr62c3xzi
 zw0mo+oIr2BrGh8hvSMf04F98h3qL0s/tEAA2nZQwH65ZE=
X-Received: by 2002:a05:6830:6f41:b0:7d7:45b7:ed8a with SMTP id
 46e09a7af769-7d776b7c63emr5396914a34.5.1773435305833; 
 Fri, 13 Mar 2026 13:55:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae3a18bsm6857942a34.18.2026.03.13.13.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 13:55:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260225173815.86528-1-heinrich.schuchardt@canonical.com>
References: <20260225173815.86528-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 1/1] sandbox: symbol CONFIG_DM_SOUND does not exist
Message-Id: <177343530408.1131472.12291209061906619256.b4-ty@konsulko.com>
Date: Fri, 13 Mar 2026 14:55:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 25 Feb 2026 18:38:14 +0100, Heinrich Schuchardt wrote:

> The correct configuration symbol is CONFIG_SOUND.
> 
> 

Applied to u-boot/next, thanks!

[1/1] sandbox: symbol CONFIG_DM_SOUND does not exist
      commit: 7f35a4251dae2b1c94c959ac15cf4d0814485a88
-- 
Tom


