Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B564BC54E67
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 15:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69E7E88003;
	Tue, 26 Mar 2024 16:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NOv7VGMv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA4A68802D; Tue, 26 Mar 2024 13:13:08 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAC8E87F9F
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 13:13:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomiav97@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56bf6591865so4551820a12.0
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 05:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711455186; x=1712059986; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=H+1BL2uDx2VImshIJZS+a8KV+wgjiA01mqabRJuOujQ=;
 b=NOv7VGMvfxv1LD9eynSkVDqVFTterkyIPbdBgcW8RpMDQiAPWrz9+Mx6HzyLqcT/Z7
 MNu5Rpv5THH+jgjX1IoQ9TQQp0003Twzcp9RwvHCLQXft4M4UQiM8QLp9P7B6H/hKy7u
 ejvOE3Qk6K8Fk06K3ZiMAFB47kcpHy3kn3gA0N2kwI1ztiA1MNvpDMLO0XdkLM1aYlIB
 ZRHzlgf++YDyDJc/ZSWY1KkQoVuEMivdd8wXQINTBxFj6zAcaor1GsOb4n5TRi7r+b8I
 GrPyqWhVP5MCvm9ivlipux2h5s/JMEsCD65kg92qJh3AE9VulIU0j9jPB6W7DvC1yh2D
 4BRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711455186; x=1712059986;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H+1BL2uDx2VImshIJZS+a8KV+wgjiA01mqabRJuOujQ=;
 b=aNLNbXdt8O9hVAE6BTsqWSUqRnr0YbHgI8kFrEJQJF1qTe0qgTDxxxEnq7I9URB9em
 TE1cwtf3YPWLK1atzFAOq9fJmmx7mvWyVUzt4urYXwRg/W3RgHkh8yxae/TfoWmtwkco
 tTFFFC3jakddQuI8gFuBYcghJWuQpj4ZeQ4O44aC0bgKxIEjEXixMsfsWMZlvvfl+YNQ
 VOhwLrGKneasXBaHp+N+UtJIG5BdsMExNodJEBE5ETAtEP87wCp6N+oI4kg1VWoGXAbG
 f4hh3qfF8HGQdBRRnaPTaUluy7Etwe8zyD4YoTI+2Vgju7iQ+HuhQee6+97NK+Pt0e7O
 x84A==
X-Gm-Message-State: AOJu0YzAeBqnUCXi5LdCLU1HQQlgH+Ic1fgmzNsA0Kevd1poENdbMYdv
 Lz+gvYc8oEG6vgCXrC8N3S4EvS5hVPmYZRC9dxwyRriYfytY8yLb/i+dTUd9xhdsSwHnIII5y/r
 37xU3U7UBIWl6/TqF8tpR4ijS9buqm5qe
X-Google-Smtp-Source: AGHT+IGn9abYehNjuF6Xx2k/LTaawzuc/1wOi1iF4jYzwobl0+VovVloxEsgmmABPW5Ig7q7ovOhtvR8oGPz5b3ara0=
X-Received: by 2002:a50:8706:0:b0:56c:19d2:85b2 with SMTP id
 i6-20020a508706000000b0056c19d285b2mr873948edb.35.1711455185834; Tue, 26 Mar
 2024 05:13:05 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Tom=C3=A1s_=C3=81lvarez_Vanoli?= <tomiav97@gmail.com>
Date: Tue, 26 Mar 2024 13:12:56 +0100
Message-ID: <CACbv49L3Hc99y0KThFsWxMJCxxpnfnKfD6weQ4Zf0H+2prnVsQ@mail.gmail.com>
Subject: Is it possible to skip building the tools?
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Tue, 26 Mar 2024 16:49:00 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hello,
I am currently working with u-boot 2024.01 and run into problems with some
of my Jenkins build agents because the Makefile attempts to build the host
tools using the host toolchain (from the OS repo) which is outdated and
fails.

The tools are already provided in my own toolchain generated with yocto and
I can ensure that they are built with the same version of u-boot.

For the case of dtc I can set the DTC environment variable to point to my
toolchain's sysroot, but for things under the tools directory there doesn't
seem to be an option to point to pre-compiled ones or to skip building.

For the moment I have patched the Makefile to remove tools as a dependency
to build u-boot.bin. Is there a more correct way of doing this or is it
possible at all?

Note: yes, updating the host toolchain would be possible but it would be
better to be able to use tools provided in my custom toolchain for
reproducibility across build agents.

Best regards,
Tomas
