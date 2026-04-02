Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49546D6AAF0
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 16:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD93B83F7D;
	Thu,  2 Apr 2026 18:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Todqjffo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CB2A8408D; Thu,  2 Apr 2026 18:32:36 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43AE583CF5
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 18:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b9c1da7ac63so186216366b.0
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 09:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775147554; cv=none;
 d=google.com; s=arc-20240605;
 b=WVrBJmp14rKqRBOqk1hu2IVddhp6rGGF5ci+5ZccNU3w4rH3GhMG5eQeJuc39dp50p
 hpMildQEIYczx54ClWYW++rHHfQZRWsL4AMw8SROMhZ2D/RuVxtvUuRgw2asK7QOTOGZ
 D1BosCboDN24eqb+SIr7zSSs624h/lrwtcOdXTJUcJZRHgGtyizDBfqsA7plAps3gLT6
 pMkIu9mIhP+uHwmUyqRhseGOy6pAuEbCbrTQ9dX8a64QNarOcPFgY/TML3DYBUOgy3St
 woh5s9wsyGK6E4dVah+GRUyoQsEHj7xpMx+TOtuuOteKlhH+eFtsZAh5nrqzkOTl8BBe
 mAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jEt+rhiA14OBG+GIo0ZWDrd5jnPnEfN7vHaCxX4RKo8=;
 fh=35sFKFBqtJHzlHya1tv5F2cxtMr7ZMDh+n2EFC8LF9o=;
 b=a+7EvZrk8ytAUUx+mem7zeT8t7ntroJgRcDVKhxS3oURBpNj1NFi9D6nVL8NUu8sye
 f16z6j3xpdW7aQiY2epFImxNG5jqQqBnpja+t6osKYk+umRiiXpN2NBQOgvoUyxtk5Co
 ArpDxPg1j9F8soP9aZG6nWSamPsdCNBhf4Ma4jXI6bZGe+F7qAJl9E16A6s73+PkPVww
 jdERwrLS2z43zUF57zWeSM3kaJQuctoW6Vo1uXv6VrEE5WlTQVjwRXo3Vkp235hsn2ul
 Nqk71TVDC6zNUtKK4ipz4MIFEBikOtmd3a8daV0gHQh5t1gYenegYFJfQrQmPRq4/XG5
 jWWw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775147554; x=1775752354; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jEt+rhiA14OBG+GIo0ZWDrd5jnPnEfN7vHaCxX4RKo8=;
 b=TodqjffoHfgaqf5ouRCrEt6kJgZWmYrTqM2A93lAb0gJgAxIBlRKPjhnnmRjCEitmj
 k/ErRQUZWxNc/dGjRZ7wD8uixtpDIPbve+Y+FdmYtBvrvKOst4Y7U9XMZz8IrbD9E8t1
 RHtIU/pKgi4gV0LPiUapgjWzONGvW8WmlN2XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775147554; x=1775752354;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jEt+rhiA14OBG+GIo0ZWDrd5jnPnEfN7vHaCxX4RKo8=;
 b=pq7A1LRGpckjmEBWo94ZkSyyoEWOFDmB1XhOEtkP5Seek/DoR1FEY1qLFjqfj6VF7e
 ozBM0vq3Uf1VsFi3q2cFon1WC+aF5Em6y35teft7z6cqT0k/3194s/hjbdeYHwZs/d3E
 FdH+93hh3NdnuL5cxIxc+8OjCS4qRi+Y1X8CW0Rj0TSpxx+YTO0b3wueUaknMC58mQjn
 +bX6lOqgpw0wFucJ3UR/AJiXAQUcHFc93oHqAAXultw75tyBp2NM6hCAksMkDcvRNAJj
 xttxFJ3RFnC7z2ftHIIfaSvnai45el6/2azDnkV+tEJvjk3JuIHj/ho2KqsMYzeo32Pr
 pl+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZf4NgU6dcvt2OzhhOGvsjQSKH52VZlUs4jXbqNWHP+nEd693fTKmBn+IcXAWatmhXkL7FUWo=@lists.denx.de
X-Gm-Message-State: AOJu0YyagE40WCQHMoWMd3BEi+aPpIW7ECKUJj6SSTqk7S+tHGMHq8BA
 bW91ODkVdHrKmCtF6q4e+RcygAbj7y65M/Rr/rfUAiGJKPhgWUWXk1xm1PT+EDXRVTkqr7pDQkA
 mC6RmZ2QW1qqZwQY6geGNe+pK5JwAwybeKWuccX0i
X-Gm-Gg: ATEYQzyL7lmO+fc1wQRWuO6plvfjwpGrPC7Cs3JF1PGDVjnxWmOwf1rqDteiOX/rGvb
 0zNaWRU5GZnRrOHIhvsChlWw4Yx56WKqC2FV813aRdawBxfDrVn/SVmT60g7zcNF0/TB1LkQaEU
 dlBvO+4CnpqyNlzSMMDx/uFE0tJhSOBSWQCFyoN9w2+SuoztUN+P7GvVD6VhO7BCl0cvhPoNSFb
 pYzI5al5dO5HoVhyx97bsf1Vg69DDL/l0lL0Ia7mtmZr44vniB+M3o976ylGzN3oBtKuU3Qrzgt
 nz3aPg==
X-Received: by 2002:a17:907:9384:b0:b98:6a8f:78f4 with SMTP id
 a640c23a62f3a-b9c3ef152a2mr184486266b.17.1775147553675; Thu, 02 Apr 2026
 09:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775099118.git.daniel@makrotopia.org>
 <2c21a4fea63dc7992320e4b2e1b3f27517e260f9.1775099118.git.daniel@makrotopia.org>
In-Reply-To: <2c21a4fea63dc7992320e4b2e1b3f27517e260f9.1775099118.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Apr 2026 10:32:20 -0600
X-Gm-Features: AQROBzArbZ2LJLd53_eqmujzNzHm-1QluQXEy5Wyde9APnhGJzmejbTOij0JeNA
Message-ID: <CAFLszThismGGmAeF6O-TYBR+sTDs=U=51gVDPCVVzf6peLphcA@mail.gmail.com>
Subject: Re: [1/4] image: fit: add dm-verity property name constants
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, 
 Anshul Dalal <anshuld@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>, Aristo Chen <jj251510319013@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Francois Berder <fberder@outlook.fr>, Shiji Yang <yangshiji66@outlook.com>,
 u-boot@lists.denx.de
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

On 2026-04-02T03:08:27, Daniel Golle <daniel@makrotopia.org> wrote:
> image: fit: add dm-verity property name constants
> image: fit: add dm-verity property name constants
>
> Add FIT_VERITY_NODENAME and the complete set of FIT_VERITY_*_PROP
> constants for the dm-verity child node of filesystem-type images, plus
> the five optional boolean error-handling property names aligned with the
> flat-image-tree specification.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> include/image.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
