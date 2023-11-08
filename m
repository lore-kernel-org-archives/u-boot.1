Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77982C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 22:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99D5786F31;
	Wed,  8 Nov 2023 23:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b="X50bJNOQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1FE086F67; Wed,  8 Nov 2023 23:22:30 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 657F186F26
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 23:22:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50939d39d0fso258777e87.1
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 14:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1699482145; x=1700086945;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MyTtaDWc5S8F8vjKy0ZCLRk6MJmMr/i8Ia7nV/hyFG0=;
 b=X50bJNOQxunJQ/SN3o7qFviFdbUBoj67HdPQT+7fcQYOqMsvfs8KfXx8FUOkZnxcMw
 x8jP9UojHst9zZrFswTycPsgsJCcpXHmuUqFVX7jX9W+t49c80TWMl/PCLf62k47e0dO
 Z+6Bgw4Xcl7qIqQYud19jZiUgqp9PZhmfApsmvaACYEf/fm/Ny5J25Ljd9oEym/PGemj
 CIsIxosABs8Ki4lEOn1/SERC2fyZastqIydKtL1EdSPXKeMUmkHTtBL6UBAlW9IucQlF
 XpRxr32+HKPaAMyMAmgvhvGJzXyJt4mP2Sxkc4dE8mrfYQDMRB8nmHZymqw2ANbn4+Y9
 GqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699482145; x=1700086945;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MyTtaDWc5S8F8vjKy0ZCLRk6MJmMr/i8Ia7nV/hyFG0=;
 b=ArtT4lcIL9G2DvRAXfJc47AviryfTaWY6E+Rkr96SpJU7VHxILECiFos2yq/Q7HJCy
 Fk97Zd/3uX3atgoNvWfixYCc2QtDeHr3o797+3SP0l/UfzO0rTpmAyr0r962KftGKz15
 ovbUjTmjMZxOnp9lf/OvssJzjg6qAWftTJu3rC9fHInX8p4PH6j1+WkWDOjSvgl5D/Qy
 i/quldzjeM2Jr/9RUjLcPYlQuYUEABlvNnhUeVr4dL2NjzbK+Agt/zvmvfwTnlB0vngX
 DKFeX84f9r4Q5HEGNWanyb260ZRswTpDXNUjaacDgb/JKi2zU/+AHowjcCwCS6y6j/1z
 S+bQ==
X-Gm-Message-State: AOJu0YxuZ2r01AbVfbgFJYS6+1cAr5L9r3ySpIcZc81jzH9GvyfadWJm
 HltQJwduErTlim9HsZoA5GPidiWeoFFeXq09rAvMG9A36dZPPiaUYRQ=
X-Google-Smtp-Source: AGHT+IEDziEDaNjz1yk8Q5PrTMzd/+I675yljGwqncrwgB+KjhmyOm1JpcbeLbYpz19l9dppgWLy8GPMAOoFEAl+ICk=
X-Received: by 2002:ac2:47f2:0:b0:503:7be:c85d with SMTP id
 b18-20020ac247f2000000b0050307bec85dmr2235581lfp.35.1699482144577; Wed, 08
 Nov 2023 14:22:24 -0800 (PST)
MIME-Version: 1.0
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 8 Nov 2023 14:22:12 -0800
Message-ID: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
Subject: inconsistent wget behavior
To: u-boot <u-boot@lists.denx.de>
Cc: Duncan Hare <DuncanCHare@yahoo.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Michal Simek <michal.simek@xilinx.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Fabio Estevam <festevam@gmail.com>
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

Greetings,

I've recently given wget/tcp a try and find the results inconsistent.

Transferring the same file 15 times in a row will eventually give me
an incomplete transfer with packet/byte count wrong but showing
'Transfer Successful'.

Here is current master on an imx8mp-venice-gw74xx board using IMX8MP
EQOS enet dev:

u-boot=> time wget $loadaddr
/tftpboot/venice/core-image-minimal.ext4.gz && md5sum $loadaddr
$filesize
HTTP/1.0 200 OK| | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | |
Packets received 64368, Transfer Successful
Bytes transferred = 93198937 (58e1a59 hex)

time: 3.099 seconds
md5 for 48200000 ... 4dae1a58 ==> 69bedfe899148c43c09a98ac950dd0ed
u-boot=> time wget $loadaddr
/tftpboot/venice/core-image-minimal.ext4.gz && md5sum $loadaddr
$filesize
HTTP/1.0 200 OK| | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | |
Packets received 64368, Transfer Successful
Bytes transferred = 93198937 (58e1a59 hex)

time: 3.103 seconds
md5 for 48200000 ... 4dae1a58 ==> 69bedfe899148c43c09a98ac950dd0ed
u-boot=> time wget $loadaddr
/tftpboot/venice/core-image-minimal.ext4.gz && md5sum $loadaddr
$filesize
HTTP/1.0 200 OK| | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | |
Packets received 64368, Transfer Successful
Bytes transferred = 93198937 (58e1a59 hex)

time: 3.091 seconds
md5 for 48200000 ... 4dae1a58 ==> 69bedfe899148c43c09a98ac950dd0ed
u-boot=> time wget $loadaddr
/tftpboot/venice/core-image-minimal.ext4.gz && md5sum $loadaddr
$filesize
HTTP/1.0 200 OK| | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | |
Packets received 64368, Transfer Successful
Bytes transferred = 93198937 (58e1a59 hex)

time: 3.083 seconds
md5 for 48200000 ... 4dae1a58 ==> 69bedfe899148c43c09a98ac950dd0ed
u-boot=> time wget $loadaddr
/tftpboot/venice/core-image-minimal.ext4.gz && md5sum $loadaddr
$filesize
HTTP/1.0 200 OK| | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | |
Packets received 64368, Transfer Successful
Bytes transferred = 93198937 (58e1a59 hex)

time: 3.131 seconds
md5 for 48200000 ... 4dae1a58 ==> 69bedfe899148c43c09a98ac950dd0ed
u-boot=> time wget $loadaddr
/tftpboot/venice/core-image-minimal.ext4.gz && md5sum $loadaddr
$filesize
HTTP/1.0 200 OK| | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | |
Packets received 64368, Transfer Successful
Bytes transferred = 93198937 (58e1a59 hex)

time: 3.071 seconds
md5 for 48200000 ... 4dae1a58 ==> 69bedfe899148c43c09a98ac950dd0ed
u-boot=> time wget $loadaddr
/tftpboot/venice/core-image-minimal.ext4.gz && md5sum $loadaddr
$filesize
HTTP/1.0 200 OK| | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | |
Packets received 64368, Transfer Successful
Bytes transferred = 93198937 (58e1a59 hex)

time: 3.079 seconds
md5 for 48200000 ... 4dae1a58 ==> 69bedfe899148c43c09a98ac950dd0ed
u-boot=> time wget $loadaddr
/tftpboot/venice/core-image-minimal.ext4.gz && md5sum $loadaddr
$filesize
HTTP/1.0 200 OK| | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | |
Packets received 64368, Transfer Successful
Bytes transferred = 93198937 (58e1a59 hex)

time: 3.083 seconds
md5 for 48200000 ... 4dae1a58 ==> 69bedfe899148c43c09a98ac950dd0ed
u-boot=> time wget $loadaddr
/tftpboot/venice/core-image-minimal.ext4.gz && md5sum $loadaddr
$filesize
HTTP/1.0 200 OK| | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | |
Packets received 64368, Transfer Successful
Bytes transferred = 93198937 (58e1a59 hex)

time: 3.087 seconds
md5 for 48200000 ... 4dae1a58 ==> 69bedfe899148c43c09a98ac950dd0ed
u-boot=> time wget $loadaddr
/tftpboot/venice/core-image-minimal.ext4.gz && md5sum $loadaddr
$filesize
HTTP/1.0 200 OK| | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | |
Packets received 64368, Transfer Successful
Bytes transferred = 93198937 (58e1a59 hex)

time: 3.074 seconds
md5 for 48200000 ... 4dae1a58 ==> 69bedfe899148c43c09a98ac950dd0ed
u-boot=> time wget $loadaddr
/tftpboot/venice/core-image-minimal.ext4.gz && md5sum $loadaddr
$filesize
HTTP/1.0 200 OK| | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | | | | | | | | | | | | | | | | | | | |
 | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | | |
| | | | | |
Packets received 64368, Transfer Successful
Bytes transferred = 26984682 (19bc0ea hex)

time: 3.011 seconds
md5 for 48200000 ... 49bbc0e9 ==> c9978ff116605a7729a1cb14ef51fc20

Anyone else seeing this?

Best Regards

Tim
