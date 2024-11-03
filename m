Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA70E67806
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 09:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B07908909F;
	Sun,  3 Nov 2024 10:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BSSfHBl1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE0A4890B9; Sun,  3 Nov 2024 10:37:48 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5B278907E
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 10:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730626665; x=1731231465; i=xypron.glpk@gmx.de;
 bh=0BM7i9bVfwA7Qysf3T7YwLaz/AZ9ioSpSx81tVzVQzw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BSSfHBl1bmDmZC/99DNFGJ0trmSZVcY4fHsy1/z6gfls/a2LI2LosBs8VjyVtldC
 F8ucIb92uuYvbXL7zX72h5E2lAdSP3+GY1NAFSdmWVp00CDWQfRtUGkD+4iMrV7Yj
 Ipw20p/9nyVlnxxfUGGEG3+OvxOAKi6PW2riM4tOaydh5O+mJ6+syM5iNbWT/jriM
 QGhm+2uovzHHEQQwvF5Qyxx+bnTsQscTfpmAImLH1qgjNMU6YU+Itp/HtUrkNHceU
 Z01VrAE++Q1M8FyAU7ePVsyeyHp3nHbfuoZvUIxRFQ6XQARiCE9guf1yEoVOdrwW/
 Rir/wqLSPJF3XHnSPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLR1f-1tOExP2XeV-00QWv1; Sun, 03
 Nov 2024 10:37:44 +0100
Message-ID: <d2c87019-154f-4142-9669-69c49b3a5593@gmx.de>
Date: Sun, 3 Nov 2024 10:37:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/20] test: Move unicode tests into the lib suite
To: Simon Glass <sjg@chromium.org>
Cc: Francis Laniel <francis.laniel@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20241102193715.432529-1-sjg@chromium.org>
 <20241102193715.432529-16-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241102193715.432529-16-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WLoSBj4D3oj3xriIYGOifZ7s5hYDWH5qA1nT7zBNpJ4NJxFxY0q
 zk7yRHZC/s53EJmeR4o33emO3Y5OMIAmq9sMykYd+ixIURe9P/8IkN6LF5xDR9+DG79bzC0
 gqSQfuHnoX9ng/Z3/Nn5sKYoJQES3xudL9sOiE0P0CZcaYjj+zJLy6z03NbxrfS/UxDYpNT
 H9weoZoEQWCBqkL5D0w9Q==
UI-OutboundReport: notjunk:1;M01:P0:j3O7notua8w=;E9f6+9Gst3+7dWoCofK5Ck0NSk3
 UTIRXVoYj+H7g56Y94tN6a2RVPXsvpER4NfI0GsEMjuO/FCU4fkRGxmZLtqtc1+l7Mg0HVseP
 cNGoG7/2hCM1deHityTHKEKUMbqiEe3Jd00Y1QYJ0leUFu5WjyV6G3/Vy95BD9nWBEpJqVQO1
 uJJY35gcPZjKI4rvqdvp6Y/wkPJtgCc3GQ+OJs/mQWt0BHdMvmEBQMxO8LKaqO9lAkHuFlUC2
 ewZfc54nGYl1tDgDEIeE5IFMNegSDJEsxC+4LOkUcOTJMlbGpGSiVfQYdPz3H1uY/hkbGW28n
 mvnXPyxPcgSSxGvFothUPstmOZDs9I0AUGTWIoCL6pe6JhixkZ3CHi8Ihr0GmYhD8tHSeLl7F
 bD+ZTlS/thbyhL+hdnxCgbcBRqMl/lDtc0hxsAyT4uYd//HW7dByHzWfV7EdN7iwhtZoo6bpD
 dVbI0RU4nGYsLbkA9NPMhvrT1vLevx2YJWu3WF0tlztYkoRCXsIud/W2dVd4rnOns7LLMN17x
 r0UtjN6nZR6KXFk8Sz71uWVz74lJ033AMNaBgXSXc5SdYs8RaODXcjtEPcqJ5jSguKrF9QQ2I
 wfPsSpVzZjsS+1dSbJOZGPhi1tUtVFzcHwDpDC36MPjPUk6Bk6Hdvp7cfuL5ZMUGhf7SMhZeL
 IRsSvM60NRW14fzfEm/kZGY4L6AsoGCpiSb8qJT+RumZzR3GXVFcNrYBOovvG3usRI6OPE7i1
 OansIUnYfviReHc3JVPppXbp40SJMPMlRfMgoua8PZITZZ3SI8H6JoCeUykRX4xd5XF6MIsxd
 YfXeqoNL8rhhpkwsN2IkmCLg==
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

On 11/2/24 20:37, Simon Glass wrote:
> There is no particular need for the unicode tests to have their own test
> suite. Move them into the lib suite instead.
>
> Signed-off-by: Simon Glass<sjg@chromium.org>
> ---

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
