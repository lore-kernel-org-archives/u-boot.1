Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0B4606A325
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QWxNO/+V;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JRbFC0RP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7835240966;
	Tue, 10 Nov 2026 12:24:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uwLTCt_fAR9m; Tue, 10 Nov 2026 12:24:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB00340882
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794313467;
	b=YouxQjI0aNR2nKbar+VJtv9plYAM5GV43vCnVzrSmIMFeZIsJZ/3snOG5w3a3NE9DCCc
	 zRakpO7HTeqG+41D+6t0r3BtpUI6djmsMyRbaC5QZYsIrhRjTS0hQ3zfwb9jnUUUO39Wf
	 KbgAITS80J7ygh0qgK/YoU/6g+yN2lpbMlAC3eqDhyR5KpXJ7QWmYrnqgqTK5flKs6U5u
	 KTwsheKBxcOmaTpHCj0mmj5m0Ao5ro/ifjrWiowHYUz8i2aRQdfKAqcvt5PH6uc9FmVUL
	 aKkT0bA9pMpTnRL1+dTljk8KNgqI9eQWlIfL2gxXmo3c8q5/hZyG04I8ipXLmcZB8Aw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794313467;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=KUVZe+oHc+LJ6IhDG/rjRKVS+PwMeVa6/1kw7GldxWI=;
	b=j3YqRtDIDDDe3LuZqDP/Rpuz+CeLHpYs2exfUKwAYP50krEGHjBK0hUOlFUkVWl8hiBT
	 ppPYWWpE5SMftlF5UTTz0h3fJtXKOl0HSfxSUWTabcSa3o6aswkXi8kYcA8A9Qw7d/5Qv
	 NpXyfML2ijm/sbNycwFwocFjQErBBn+4Mgc8SMlrQ72lhsGi0SHLeQ1p3Z3O5+xYcTftM
	 534GImPcR/bsTf+Gw7vNXmXmgyAeOyUjodnpxvtFvhP7NbMHyuxAKkr9YH6uxKI2NYtyY
	 wLYd8FZFzfGhalwKxhiJP0m3dy0agUibhTyJ//cZyCgyN1mDgwrXlmjunteIZ6SBrJQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794313467;
	bh=KUVZe+oHc+LJ6IhDG/rjRKVS+PwMeVa6/1kw7GldxWI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QWxNO/+Vd3lCJzn9cjlZB+ONw4hyRG29sAp0LzlkXIs9R0MdNslNprTWjXqXmdOkn
	 nR6dd4DAdZmMa382rcwmY7WdLcehBkfylLUfcK7K7Gsq36x5epnVdUbn31tx2u+r1h
	 8ipUKrZeEn/RqN1M6S06XKtFd74p7fgyTUXkpAMltHj5b/rGcT9lQPoaJmik41lvEu
	 3H+zmCozazkRzsRXYLd4ANqPcjlvTjW3HIMi2/pb2ezNORyQUyCL1kfCr0BC/FlTYw
	 9RFQXUJ7m2tRbm39TYy4/TX3trvSJmzAMIgJQxwMi+d5rd/SR2/NWvQCghMKetlsUV
	 SOHYc4iO5eXKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB00340882;
	Tue, 10 Nov 2026 12:24:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 56347731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4731440347
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tt9HvP8d2sJV for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 12:24:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5AE2B40176
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=andrew.goodbody@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=JRbFC0RP
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5AE2B40176
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 12:24:17 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a2072b9832so11249805e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 04:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794313455; x=1794918255;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KUVZe+oHc+LJ6IhDG/rjRKVS+PwMeVa6/1kw7GldxWI=;
 b=JRbFC0RPGvQW/r/KxSJBJ1ek3R1qMeWive3fF/CG32CJt+qM/mGTtjPeiYZiJwsxAI
 axpKQnw8pJmN+SGuTjUm+n/PijojuBs7i6sPdlwYIJCPh1ksw+1YOwPvSwQQrQCYVxwC
 hxQ332in+cgFqP1/sZZx75ObZlcjg7DUJR0eayeVEy/tREwNbUYk7s7scXRzrzp0Nrh+
 XLMzKsvajS4sbC2Pmi8ScYyzLNe4/YFm/JrHdatSXpf92BJW2nmE/dQ6EpKNSo3eSmpU
 ssD1mPkJAcxg9lHo9dLskSYNv+R+Yf94WIo6S+Lw+JjjNwLY+oCogOdnc7IrnuvdZyYc
 mmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313455; x=1794918255;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KUVZe+oHc+LJ6IhDG/rjRKVS+PwMeVa6/1kw7GldxWI=;
 b=Jaop0fT2unqu1fs9SVOWdUGQHbMpYdkm3vJ4AiJf5byg7QuyLQeZdbot8PrHY/uKQT
 70abwgoQ3dmpgz1tM9J5K2xwR2irSTaH0ZQp5t2lHVRbS52GgiUTXvWzQL/CrQc0A9Lp
 Q9abz/q/BJWM7u32l8YHpqwr9L9ryz790zT423tBmhwSVS11Zv6SOxOPtSeldoFBox1O
 mQlSjA/7ChpBflNvzhbe2M3PwqpIV5SIuhVthh4HbwxVQvAosjDq7+nzuQcP9cWqsg08
 CE9cYxWRvvVfVDzzkjYFZjFztp53jK6Upeyds6/wrbyLDecfjPXtHBHwTOWqbzJROBwZ
 7Ejg==
X-Gm-Message-State: APuU4Z8ZZYZKUpXHzTUtddV2UWDCEeWDim4xZa1UpR4F1bWS07lhClKO
 +z0dkj4hhFB53d8p0nprnkfTYH4mOLziLUtBiPvToZYoMP5z/n7aki9zsKGEqEBQiks=
X-Gm-Gg: AYBFou274RHrkgyVg4v1kv5NV3LNOEsDLOculWKR3kQkYc3j7r+zBsGkCL/XQgfcjJ3
 5ITgvShFiHD0i91adYp+No7TJzKstD+8Psj3zv9O91xlnDGLsDN+4vDDatlXagbKFv1tEwwwQRW
 XGs6R7jiHwkFJwzlGyJYPcPLBd/FX5fkmPxVbHFfn4Jc8SHiwlMjG8SfCkMjxdUPdlPMb14gj2V
 XbUU65pFQE/xTK2Lx3NXCPzaFxP1h0cLNZEDDaiP3h9U54YfAXGR4ByRdUNe+t1AfZSmsxMVyL2
 Mv9a3wdU5YL0ChQI6TcY656GFaiuy585a/vHyC5uHPY1PkOvikZawvDBfYkVQzP+//DwLP9q3MQ
 4r8kMpmWqQchtyeVsdO6aiRufYdglA0+QLkLC+lcYhejolZOZzAuhIBe8LR60AkgyOUVHf1EOF8
 5Qe07ZalTDbdRsu4J/hktN5FE6l7qGjPgzFO9xtV7z82LWmNIB/9OvKyG6nR+WTksu0VtauG43R
 yNC/tZL8gjDhgbHNhl+ubMX9JeJkRDWRRZ7DrXboaN9K4r2LVkoSsGh+X1ywUq1+CemTvUqhlgp
 043ajktwb91S9h15GXPFd4dXrRr/ALYqJ1zBlxYW4kkizVMeXp1DRxA/lKyvdMjCsMpw0g==
X-Received: by 2002:a05:600c:500d:b0:4a2:18c4:61a5 with SMTP id
 5b1f17b1804b1-4ba0233cbf4mr41363325e9.6.1794313455119; 
 Tue, 10 Nov 2026 04:24:15 -0800 (PST)
Received: from artemis3.elfringham ([2a0a:ef40:e16:1f01:e865:f651:6131:9a7d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fea9eesm99279315e9.11.2026.11.10.04.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:24:14 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 10 Nov 2026 12:24:05 +0000
Subject: [PATCH v2 08/12] test: Build mkeficapsule in tree used by tests
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-qcheck_fix-v2-8-1c76e0b68f29@linaro.org>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
In-Reply-To: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
To: u-boot@lists.u-boot-project.org, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anshul Dalal <anshuld@ti.com>, Alexey Charkov <alchark@flipper.net>, 
 Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since the commit to only build mkeficapsule when needed rather than by
default, the build tree build-sandbox_spl no longer contains the built
version of mkeficapsule and this can lead a test failure. Add the
config line to the defconfig so that mkeficapsule is built and the tests
will now work. 'make savedefconfig' was used to generate the new
defconfig file.

Fixes: 2f736e8e3f4b ("tools: build mkeficapsule for CONFIG_EFI_HAVE_CAPSULE_SUPPORT=y")
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 configs/sandbox_spl_defconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index b1112fd45e7..34ad509a85e 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -1,6 +1,5 @@
 CONFIG_TEXT_BASE=0x400000
 CONFIG_SPL_GPIO=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_SIZE=0x2000
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
@@ -123,6 +122,7 @@ CONFIG_CPU=y
 CONFIG_DM_DEMO=y
 CONFIG_DM_DEMO_SIMPLE=y
 CONFIG_DM_DEMO_SHAPE=y
+CONFIG_SPL_FASTBOOT=y
 CONFIG_SPL_FIRMWARE=y
 CONFIG_DM_FPGA=y
 CONFIG_SANDBOX_FPGA=y
@@ -214,11 +214,10 @@ CONFIG_SANDBOX_TIMER=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_SPL_DM_USB_GADGET=y
-CONFIG_USB_GADGET=y
-CONFIG_SPL_USB_GADGET=y
-CONFIG_SPL_FASTBOOT=y
 CONFIG_USB_EMUL=y
 CONFIG_USB_KEYBOARD=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
 CONFIG_VIDEO=y
 CONFIG_CONSOLE_ROTATION=y
 CONFIG_CONSOLE_TRUETYPE=y
@@ -242,3 +241,4 @@ CONFIG_UNIT_TEST=y
 CONFIG_SPL_UNIT_TEST=y
 CONFIG_UT_TIME=y
 CONFIG_UT_DM=y
+CONFIG_TOOLS_MKEFICAPSULE=y

-- 
2.47.3

