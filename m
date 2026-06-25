Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823B8CDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 16:26:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A81A984894;
	Thu, 25 Jun 2026 18:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XTR9wbMf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71CCA84942; Thu, 25 Jun 2026 18:25:59 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 575CC805D7
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 18:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c0d6c75c58cso175190366b.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 09:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782404757; cv=none;
 d=google.com; s=arc-20260327;
 b=KcKmsFpjWzjBEEzpuRnoHu4brvFfCv0plRNKSSkty8PnsM2WlSbFshO3Wh2yD5S4zi
 bZ+PTKcr7jYyVfIvFKw/kEf+sXfYhBnQ3e2VjcaZTkAoEr7oV0lKjq4D8ECy0ebauRzZ
 OeTn6Z0THw4m4ZHKoVvGaBn4UjO6v4GIgotFtygXcR6FoM56iInwOID+MvFjT4aHGWhr
 xsMqnOHFekL02QdYIUa/tX6dxcSukc55UhGaCPexlHzXolLpyCA5ejrPXG7PethX8/KO
 Q3DtxzsD9LOw3yBq1DUznanYc1yg4YXegs6YQvwKJgb/9UbVv9OyczoaxAk+7qrsJrjp
 DX2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ay2lVN903vk/AgzAC6vOSEBMnLHtVxg2oX0c8lFCz/0=;
 fh=wAc3jt8SFcZ5fvrWGwAtGaWa1TsSE70JIemaPR+D+yY=;
 b=S9Byo8o0Uz2PMj0BQmbzAwdC/5nGUg4h945PzAuEO/QVs3AKGKirnYAzyO+ARjQuYh
 kcbROE1ie5xQ4YmNm3kbmf1lxN1IAH3L/lZKtdCObHCNlJaykUV3np6UiYjQRLUrs21j
 rqt+1E9rmPdJ+HMd3yF9lDL2NKtkMZEX1hDOuC2PacuSsVNDWKiJ/qNuMaadOl7J6o47
 ZlXDk4fhXrfcKscHPkp6+3Tv4ytTKvyoOYx8ggbcwDtD3Uud+Lv6OqVjN7vhPxjPtSYB
 cE89gCJt2e9kAHD6JPjN9w1ji4lF9JNCfNp6Uw4kO4xkXHUvTRPa3BJ8VHU/supUcus8
 4++g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782404757; x=1783009557; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ay2lVN903vk/AgzAC6vOSEBMnLHtVxg2oX0c8lFCz/0=;
 b=XTR9wbMfVANQTYAejUmtNVk96X26pbaCazD62EzZg0V8OHKl/VvY7+PtmS5z9GSpBD
 sGCNCPcokaDkr3LUl0gDuxw+xXvJqQe0rJPTTN66xMugz8PbiQfaW272didzLuWDNbh5
 2X4H/FNZp5P541YAl207ydMLSEUiI/rS1WFq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782404757; x=1783009557;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ay2lVN903vk/AgzAC6vOSEBMnLHtVxg2oX0c8lFCz/0=;
 b=h0W7ALMO+zzCZSD6mBEjJlj4jwbaRP1xJ85bGOPxyk0Zu2QGPhfDpt8mLz7qk4uzD6
 3vFEFnao88VD85dMQR5lt6ExTK2YiUjuaz8ahocT5FdGYZ5qNCvyfodituBlbh8OTl7I
 5OcEHfKuOMUs2+d9lqAkN6O1JzRHeivCO/807wfGFBduDR9u46WYWtH7Jyg9K6AOjL35
 ORbsYKsuRuph/N8JbmD+v8c2czTC2Yf1Ad5OVbOKSLJ5O/kZueg4nYuAdwhcCfg771+v
 ZWbhvvO/lWXopHXhhiQnnnldmjraGpQptfM/3rnp7pXKtCVqsdUd7BcpB2I1a51zjuhP
 ztXg==
X-Gm-Message-State: AOJu0Yy8Q4EyC9CFOUp1Ig5c6wfsCCfcyO2SejE+OcQ+59uupXlUKm7L
 jMYx+dK3NJiyTaucENg5SqT7QTreRe4bUSauwdflrGHovVFb+dIu+oNE0W65jZKMkcnbDekO5oH
 ppCIJtQuEdnyiIB3IPdficjiBExmFlz3Ad5Jvc7C3
X-Gm-Gg: AfdE7cn6oEchldxKORF1ahu5fwWL2YWQyPtIot2zDa4pSbJnJ+OXw9FK69o/zda7vsV
 6ZFLvpOF3qCukBCues/lJOB2QR9K6Ef55uwHmEDJQrioZWUwApiv/6ceHnBMZ75JDHtPFLsOvok
 OxEq6y24JGpQMrjs16f2j2R7iOMJ1eU3JcgKfMdmerADGpzoYLMlNlvlj44AFjHE2GCo34BSmXQ
 LZljW+LuTtno4Y5xmPVxm3QJFfr4Bs0N/kIn4MM6TaIYI/1E3JyyKO0BIuBaIHL3Hqe7JKXpg==
X-Received: by 2002:a17:907:72c7:b0:c0c:48b1:21ca with SMTP id
 a640c23a62f3a-c1205ef1d74mr251782166b.29.1782404756025; Thu, 25 Jun 2026
 09:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260625-rzn1-usbf-v1-0-0e1a38f7b82c@bootlin.com>
 <20260625-rzn1-usbf-v1-1-0e1a38f7b82c@bootlin.com>
In-Reply-To: <20260625-rzn1-usbf-v1-1-0e1a38f7b82c@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 17:25:44 +0100
X-Gm-Features: AVVi8Cd7sze5V-eiUCzhl4c-6XEPMbnZaj1qaC_V1ERdfKGpEh5QbQIvGY8JqTE
Message-ID: <CAFLszTizFJ=fNewsWA56_rpcNSZXkcMuP1z6jiXmd4mMS0YeWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] linux/list.h: Add list_is_first()
To: romain.gantois@bootlin.com
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Herve Codina <herve.codina@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
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

On 2026-06-25T09:05:24, Romain Gantois <romain.gantois@bootlin.com> wrote:
> linux/list.h: Add list_is_first()
>
> Include the list_is_first() kernel function, which will be used by the
> Renesas USBF driver.
>
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
>
> include/linux/list.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

(I don't suppose Linux has any tests for lists that we could copy?)
