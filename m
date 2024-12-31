Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98404E77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 04:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B654F805C1;
	Tue, 31 Dec 2024 05:05:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OiY9KggQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8769080657; Tue, 31 Dec 2024 05:05:33 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57C0B804B6
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 05:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-46769b34cbfso145638311cf.0
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 20:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735617930; x=1736222730; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38A4ahJW0MYtE3JZlFU5tpl04QEPNIiE4ONNCFoVXRA=;
 b=OiY9KggQcIViPuvCJptaE7HFdGygKUI0GZ6DAuulr5WpRZH6q//YZiOcrsSa3y1xty
 jrrhEcEXYnjj/Y7Fdc5KntV9oeRR2Ttp7/7LT8HQO1hJBzTAh0m0gxhP2EMn0VyG6cEl
 U887W5hqeffEyqwVCLFGq2gY7kS9ZlIYHscFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735617930; x=1736222730;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=38A4ahJW0MYtE3JZlFU5tpl04QEPNIiE4ONNCFoVXRA=;
 b=YzU77TF19u5vUKa32OERj++jjI3+0RfPpNU3DBkv78bfyckvCEIT8947MJjQqDOjv0
 JSFI/C7hU+sGFEm+nYKsX6nrxU10UyIhNggU8ZYPgqxFIRfClRc7D7i+s/8M7qU4qzUp
 21PhrWrA6Uqlm6duiz4uAMyfBnrhfeUTZx9XkGRNi/m8zJ95JodkwZA0bLWdN1fY7qcX
 boToPqQmqLVhSEU/W2/oAhSCPrhcVIxBLNcd3LhRAlBRYLdUW8HJioZHOUjlWgy6OQSp
 0pX1jOHXxsWAdczxjZoie1mJkQElsY9nBzMsF6vgqVxD5rjD9vwIdJuHWcUA4rSKAYHz
 3d6w==
X-Gm-Message-State: AOJu0Yz66aXJKK7NjhbSz4QQ9TJy+WJw9UfdBpgnZhgWkRUtgTijluc2
 F6fJXtdZC1LhXcDwh/3bTaJ+Hn3altxvhfBl2lotrkVD1YDdChyCWgMRJ3XZYjk=
X-Gm-Gg: ASbGncuGEDVkpYcQS5Rx2jcW3rUFt7ihoGBe7rVodzqDiJw0oWle7RInR3q+SvGtFVW
 NWNO/aglpPA7DpRxLNP3sKwyK3ghH7k5GV4R16LV5v/yIp83ulIfYkjMSIUiV+xfoImF6lYAl5S
 KVhTZkHV6kIF/i+I3XYXxhs3bvK47rtUqsxtqNV3ZJhF6rBLR1NhCjV48Tp9Azdnne5sZyWyZ2z
 MFWgkvPTSSQAQTutSo24M+d9UXmzkZ91kv3xXPB7QRlRJSlpVTRaO3J
X-Google-Smtp-Source: AGHT+IFW87QGG9xQaXekJ9EBivY5sMH5Q/Min4TasPYxLcALFbvMOz6RGotr1uB9mmnyOQzz5uG4bA==
X-Received: by 2002:ac8:5fd0:0:b0:467:5384:50ed with SMTP id
 d75a77b69052e-46a4a8bae1emr633390471cf.10.1735617930092; 
 Mon, 30 Dec 2024 20:05:30 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac480886sm976081485a.83.2024.12.30.20.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 20:05:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: JJLIU0@nuvoton.com, Jim Liu <jim.t90615@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241120012154.3335110-1-JJLIU0@nuvoton.com>
References: <20241120012154.3335110-1-JJLIU0@nuvoton.com>
Subject: Re: [PATCH v1] configs: arbel_evb: enable arbel feature
Message-Id: <173561792820.257558.15903392552310783571.b4-ty@konsulko.com>
Date: Mon, 30 Dec 2024 22:05:28 -0600
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

On Wed, 20 Nov 2024 09:21:54 +0800, Jim Liu wrote:

> Enable GPIO_HOG, net, WDT feature for Arbel EVB.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


