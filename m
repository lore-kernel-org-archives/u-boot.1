Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B59C0018A
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 13:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3031A86B81;
	Fri,  3 Nov 2023 14:49:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IDi3CoUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C1F086B18; Fri,  3 Nov 2023 14:49:52 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C817871A7
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 14:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32ddfb38c02so1259492f8f.3
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 06:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699019387; x=1699624187; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HJLvvIiRtomqaDKitTrYOEHsezKmLsC96CVrOr+1csM=;
 b=IDi3CoUSgINxXDzz/JR0UmkLLf6KqBXPLS6RzGHKiTgKAMjvZFMLrfEr9eLlL153LQ
 fOpRy0QYyvWwCMKWCzbosw1c34yvNKUJRhGgZIEXi7QiP3b6zBYSxe1WeyRB6Y4ULKHb
 Y9WmlExkOyhivA39EzBzbV4vD4/1bfeItyqD2anvSWiNOUrQkhxo7Mj747qYTt5eaumv
 jHK0LD/0wsczESfFdvQ6AMTMd0gLUjvf/4kGLiLNOuAf9spbOt4ejIn5QSXt4jWllSr/
 8gIdZzZ/JRinAy2O8+MX1mz47r7+iIqNG8WZhXv7//fZGk4rQbtYC0Yzhs/XqEzNteUX
 P50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699019387; x=1699624187;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HJLvvIiRtomqaDKitTrYOEHsezKmLsC96CVrOr+1csM=;
 b=wpSCGKnokkpYzMGX1p6n/a4KBY8lnGezFk4XvoqLhNxdaI4k6e2Xy6uYeu6vQj4Dpm
 MZXkkY13KuI7ssgo2l6nE2M6udT8qxrkCKylyby8C9PdlB0URse7kq8xSlkHGoW941HU
 w+eV49DswRndeplXpRgaYzJ5c0wkhvwGMzTpsUiSRgv/wDiiKRttrhqd/T145mVuzCs1
 p7WFr5M370J+BVVgJf8xXLQJnEBHsuIkPiUHA7ZH8UmqLyAGXzkJY6bu/t029maYo7SQ
 q3ylLHGakY67K5Jvo6REvjw0XGNgeyH5ZBt5ly3390ogx8i0foaGfAKeqCWEuIshQtGo
 Rd3A==
X-Gm-Message-State: AOJu0YxZoyqlq5SZ0uEhtTrL+f1sp2T+S9X1n+DtzX0ZffD83wiPlzA4
 ntPuW/I3nzZ0+og3kk3Oq7PI4CvpQk05lufoX2s6aw==
X-Google-Smtp-Source: AGHT+IFh5UYQ4JwBk/wJdFCy2BiwyQ9+EFKZ4zL5ZHVt6BXyLwlsNjk/y/378egLrfy7kV/JCraFSg==
X-Received: by 2002:adf:fa4f:0:b0:317:5747:b955 with SMTP id
 y15-20020adffa4f000000b003175747b955mr17609303wrr.17.1699019387711; 
 Fri, 03 Nov 2023 06:49:47 -0700 (PDT)
Received: from lion.caleb.rex.connolly.tech (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 s16-20020a5d5110000000b0032f7865a4c7sm1937326wrt.21.2023.11.03.06.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 06:49:47 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Please pull qcom-next-20231103
Date: Fri,  3 Nov 2023 13:49:46 +0000
Message-ID: <20231103134946.365001-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Tom,

As discussed, here is the maintainers update for Snapdragon. Sumit Garg who
maintains a few of the Qualcomm platforms in U-boot has also been added as
a reviewer.

The following changes since commit cbba1b7766bd93d74e28202c46e69095ac13760b:

  Merge branch '2023-10-30-assorted-general-updates' (2023-10-30 16:01:54 -0400)

are available in the Git repository at:

  git@source.denx.de:/u-boot/custodians/u-boot-snapdragon.git tags/qcom-pull-20231103

for you to fetch changes up to 48eb294bec471d5d4e176ad030671a221f307074:

  MAINTAINERS: update Qualcomm maintainer (2023-11-03 13:17:50 +0000)

Caleb Connolly (1):
      MAINTAINERS: update Qualcomm maintainer

 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Thanks,

--
// Caleb (they/them)
