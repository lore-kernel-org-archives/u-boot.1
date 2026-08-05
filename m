Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F87C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 19:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DAFA402EC;
	Wed,  5 Aug 2026 19:41:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TaOOfiTi04wF; Wed,  5 Aug 2026 19:41:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D0A27407B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785958879;
	bh=NTx/sSgojoQ1jd1Ssdcw2NrwZ9Bt0858XUKDc6b6qls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gRbKWpRZWd17p5MVaVpn+4YFFvWLt975EfXPvA5+XmUkSUV09ssjSnTmEiICRGlo/
	 VZgyTQOdUAm9m4G5ngmWfUEMsbqL/8fJPdt16LduXeNHDDO3UPy3SrTg4sgTTHdNnR
	 xtwfN1qoVRXPhJ27M8nfq13SfX043HRVcMj8M/JwPPXrhDb1m0SndcF1Le6JcNacCz
	 BrvlzZ7vkkP5PSkVWI4GbqvnxEIwenQWoIYGeCcslqpJkgXKR8YO7sm+HEFSUY+IzL
	 67EpghikHqymtcxzGvJYlxqy4wWYh+zCMTgvT83p/YdRa2z0jOCbSNybuMRhgr2xM5
	 ki6zIPPo2xlFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0A27407B5;
	Wed,  5 Aug 2026 19:41:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B7622A8
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E76A3407B5
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:41:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id geBXsUHrvQNR for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 19:41:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EA0464076D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA0464076D
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA0464076D
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 19:41:16 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7eb42a2f5feso725259a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 12:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785958875; x=1786563675;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NTx/sSgojoQ1jd1Ssdcw2NrwZ9Bt0858XUKDc6b6qls=;
 b=s/JEEUnviP1XHmqJM+idSLIKN2JnPTpAte9bKsvbuAwXUlGmeLw974uLAn4/wqYX6e
 Hj7PLYRBU0aFxGeutUvBZVhPCP0rpBQ7mRQOPhBDqKzTvQpRBOjpBvU5R2kc5RUEwjgL
 1soZMN0N6136IjqcTgXZgMZTl9X/kXwIYjTM246iNIyJ7Eil4CpyIBURJUTkxtxJHkjZ
 eTEkIspejDbTYZcfgDwKIyZrgb06gwNUh2ii8wQLJPzxPLx5d/kiL1zwylfUqMywqOWL
 wl4izGqwdMn34RaO59e+B49CyzgiwEsxKc1bWrAuRWp9rO8miD3HV25p43CJhE0lxFI6
 NWyg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqMSuEDHw3Ge60qd3PFf14XgKfcUTpRrwAD84467v7SU6eI+T+xR1Kbe2MmdA+gxpknpEM57LE=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxiV8FyqJc90UdPNQT7i5nOy4QNk8pJzQtKA3ktr+SBTwmAG8P1
 zHIZx/BEjGGmAdPwxF+iMzKPlMWb+efVByr0wwdGTD+gD1yPI8zyHDK7QtsAgmRVSgA/Gz2SZUT
 P8/+2m5c=
X-Gm-Gg: AR+sD12qfyTEkXOLPqlcWWkmJY1Imp4s+9kAe+vzKeLSSJME7HdvyFvSpVjkaPxOg73
 RK5guGb94Rql/f3uXOhHP/qQ3pCvMGq48ktDsbyMWY20wUzX+H6Wru2KYNI03dwgQQmySEi1qQe
 oJay1nV7e49jBgFNpTX/xo1QII4IatQmlRMXcF3Lz5bUcD9uHtQ2S8z/OC7HfEsGtPYXVfZNlxO
 qEQZzFoCaut4zKOF3XrW4IEdGuRQh375NkXbGhaFAFGYH/Qlg3dREEKnRXmX7cyNpEPFcgeL5eq
 STS3ZY4Hv1j8fsFJhY2kei4DokrLsc9ANUHVeIMnwbzvQpNM9R2Tk4Qwqqn3cXx/330wJGea+rW
 reSuUn2wkXJ+eWy2UNRCkN8eDBJ0SSyc8xuhPlmSq8EAbIu9WWHVokkNWxyOB7Vxa4snJWqAIjA
 QzcoohBBe7/HB2lsR0Batg2SgDdty1ydrx9ZjMsgthyJmR0jLX4hYVVaPXrsJoK5e4Mg==
X-Received: by 2002:a05:6820:4de7:b0:6a3:81a2:746f with SMTP id
 006d021491bc7-6ae97084924mr4799291eaf.33.1785958875424; 
 Wed, 05 Aug 2026 12:41:15 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ebef:9550:d591:36ac])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4599e1bc01csm3439682fac.4.2026.08.05.12.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 12:41:14 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <20260611-fix-ufetch-compile-v1-1-43f2e3239265@baylibre.com>
References: <20260611-fix-ufetch-compile-v1-1-43f2e3239265@baylibre.com>
Subject: Re: [PATCH] cmd: ufetch: fix compiling with no CONFIG_SYS_CONFIG_NAME
Message-Id: <178595885844.2270888.17712095738326619093.b4-ty@b4>
Date: Wed, 05 Aug 2026 14:40:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=344; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=HeFzuXpM7SQ8b4ICuTm3p/D389C40Jk/CiJKvIFrGhk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqc5HT2NZB887/Qt1x3VbAZ8QxOSW0mHOT4UfVQ
 ZQvIpSoexWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanOR0xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AdpcIAJdkazxdOe29+E4afh4O0gHrdMyBSrY3b8yFtv3
 sybyms5OpycXSmp8d13p6DL7js4tQ6rXBKnOZvRoz2w72A3Y2/222Qc+BWzGHOVXmn2rwV1drWN
 Gruy27XHf1P1D0U0977gbLHhYK1+yu5j8uw2sqly4qz2tK2AoqJXvyzeUFsv+SiCZIJ9HvnOurh
 ydTAZmvzQShDIb7PAt2uVV8y+ESgVlKQY6yculhT1gNQrotSMJgDsH6/zdJZ2M3vtzGW6cLmqtZ
 oepvWFnx8BAkiVZtryYyF+lfnJ9IO2i8zuf1mB1W5X9OyTFGbuj7VI5/Ic5n+wI/U9o/CWyqcaL
 IQDo=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785958875; x=1786563675;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NTx/sSgojoQ1jd1Ssdcw2NrwZ9Bt0858XUKDc6b6qls=;
 b=RxyrU41ohH0gvjR1VUlOyh3icNMaQmNNI8WwMBT35kpuDmbSPEElv0bmDAzsX5JHR0
 vYrOzyGi32mB7HdJd1p4PpVr3c2y++W8V8KjVVykfSPaeeC0XxtlRh5XyWzUcNW9WqPu
 luiCMdsR7ySkOVGXEmWAFNaVZGe0f7C893khbbJTf2OAeHKuGTbTuuUQIgC8KPGNeThj
 jZO+tXrlnUuSx3zy70QRZ///AS+euQbddgRf3sjrrJe0nuhHhxPMWQOWGy+7I6aoWtuD
 SJE14HxBruoY9TpYD4oYveblornl4l11UH9JJzhYNzyl5MaB56T2HCiOGQ6Y8Sd0Pc0f
 rx7w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=RxyrU41o
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, 11 Jun 2026 16:59:13 -0500, David Lechner wrote:
> cmd: ufetch: fix compiling with no CONFIG_SYS_CONFIG_NAME

Applied to mediatek-for-main, thanks!

[1/1] cmd: ufetch: fix compiling with no CONFIG_SYS_CONFIG_NAME
      commit: 478103c24626d4f98e15c374d171de522f903055

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

