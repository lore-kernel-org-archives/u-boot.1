Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC0CC369C2
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 16:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A69481F0B;
	Thu, 24 Apr 2025 18:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EFv/qR5k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33BA08003E; Thu, 24 Apr 2025 18:43:43 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07ED88003E
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 18:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3fea0363284so856083b6e.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 09:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745513019; x=1746117819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NzT2sEVuUdHhZJUwWRez04N7SpVjgYZvijPY6DKmPsQ=;
 b=EFv/qR5kXnOMNVJElxoFYMAJGiTeVOhnovYctu85FQ64oRboWiCTGEP2Y2wJcZZinJ
 0MuFZKds+PHPgp7j4GPVs59clXiY3oDrpiYvZ1H0Ys8/EinBP5yahcfrrpnSQX0oC9d0
 n8pyVDJORHW/2DCZBjQdnAal30uJGuXjK1mZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745513019; x=1746117819;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NzT2sEVuUdHhZJUwWRez04N7SpVjgYZvijPY6DKmPsQ=;
 b=kR49MRz9UQweOZemvMyRY8bvKxsPnYwvlbLJT+/15P8IyXRJgU18E37gU0KlZVtrJk
 FiEhXwbFohUb/T+mYD7SN/Vu/CtEwWk9JVzMrucHay/bU4MT1NSHz8woedg+dVxt592P
 fyFOOkALCpQf44+O7PuUHQIqNOl38RgOXYi2PBi+r1TtdoTLDHFA+qplUgSbMngstw1u
 Q0lb0kQfsC6ZWlxyU56Z/U02GFDLstthojmkD69HegmKtiK/6SZn7qmj2dVBH8iWdliZ
 S9fEk0MGfIXJOWE0EsCPsM7DZPxFS2TJA3Eo/4qA74FN2XwcL2xOKA462GNX1JgOwU/p
 TfCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE7hPkjcKL3/BrIFVECirflZvmkDgoqDzwc1ivydgZ8LKvzt+YtwdciJ0qY36LjtzaaGxJPnk=@lists.denx.de
X-Gm-Message-State: AOJu0YxCWPRW5X+rTL5IOrI1uFXt4dri7xVQ2m/xkHSbStrktDzrf+go
 szaY0GODOtylFx20uEJNq99iehr0+7gX+NMW6/z25PQ108jAmlTJpllWLH8eT3o=
X-Gm-Gg: ASbGncvsjUOCqiCYfODCk/uyXIljFUyHAq9gP6Cv2xfkQy+Ag1lrOpa3d6RVFvvfE5r
 9dVTh4B/NXAvwbcnaiSN4DT5TAeud+g0cifyfp+8eQPi5g1HBrwkVeULyvXvfPo9+oEmxz1QhWt
 zJPhU9O1uHpRY70xXGG6JZRXmXa9F8x/lHnZ0I85ClwYGsSXrHcaAHOmxYEe6ejL2NdowW3J7Wn
 A4nBsiIKlRjhy5dCv6O+2rCMYiu9+/DRMrqIj0xeux7AfY41mPTwlpKAB+HecxyXJih41fCemtt
 N0KWmxqLcNZfPCUnC5EYVJfqjf0KLl5XWx7k4gig7t5J2kk3wKf0ToAMyNxWnj4NNgMrcZp0JpQ
 h
X-Google-Smtp-Source: AGHT+IG9TUWvai5DU+Ht/w3gTHFy5zs43Pob9A4pT8KJ7irkQPQgwYwdkxekne0m30mq+iYq8wfWPQ==
X-Received: by 2002:a05:6808:1818:b0:3f8:bbf3:3a18 with SMTP id
 5614622812f47-401ec535839mr1583514b6e.16.1745513019629; 
 Thu, 24 Apr 2025 09:43:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7304f2af97esm297869a34.41.2025.04.24.09.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 09:43:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Samuel Holland <samuel.holland@sifive.com>
Cc: Christophe Roullier <christophe.roullier@st.com>, 
 Erik Schumacher <erik.schumacher@iris-sensing.com>, 
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Philip Oberfichtner <pro@denx.de>, Simon Glass <sjg@chromium.org>, 
 Stephen Warren <swarren@nvidia.com>, u-boot@lists.denx.de
In-Reply-To: <20250414193015.2094578-1-samuel.holland@sifive.com>
References: <20250414193015.2094578-1-samuel.holland@sifive.com>
Subject: Re: [PATCH] net: dwc_eth_qos: Fix hang when freeing packet after stop
Message-Id: <174551301814.4069373.967487336786233759.b4-ty@konsulko.com>
Date: Thu, 24 Apr 2025 10:43:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Mon, 14 Apr 2025 12:30:11 -0700, Samuel Holland wrote:

> If eqos_free_pkt() is called after eqos_stop(), eqos_stop_resets() will
> have been called already. This may prevent accessing the MMIO space to
> update the RX descriptor tail pointer, so we must skip the descriptor
> maintenance logic. This is okay because the descriptors and tail pointer
> will all be rewritten anyway during the next call to eqos_start().
> 
> This hang was observed after a failed TFTP transaction:
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] net: dwc_eth_qos: Fix hang when freeing packet after stop
      commit: a948f5711844498421432719c4c19d9629cb9c05
-- 
Tom


