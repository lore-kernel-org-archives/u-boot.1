Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F304DEFCE5A
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 03:06:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AD198063E;
	Thu,  5 Mar 2026 04:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b3KNH/2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28AB5839A8; Thu,  5 Mar 2026 04:06:27 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED4B980212
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 04:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d4be7c4ebeso3784424a34.1
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 19:06:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772679983; cv=none;
 d=google.com; s=arc-20240605;
 b=iSdHybC/V2ahqR63kNxzO9VURRaqNquxYUCMzwo0k0RBfMXcaJc3hIimymuv5RaF6I
 65CIzntRP5qvkgzrF+Cho5PKXBkozDQl3hxtmOklZvrs8fZeXcKGHM3oGm5s7+xwJpIO
 PyHEI5wwsOBeRUtqnjWgXJHhBZ4zdiv8ByA1u+aOSR0/FuOA3Xe2Nk982+S7KViFWbNs
 IWyaKJuAxZ/dbfUuBKybHVnNOufPl/keMD2nW40z6Es9RrP7Uo10UFFJhh6Pu0kTLobR
 UxIKLrIYaE58aF+f1iUR5ujqIGyaNqbvdygNFQNFKHcBDMojMBYeEO0laBxHrM1SXHsO
 L2UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=0U9WrbwztNegbUjYxWboo4sQNa8ZuN6iXyGby/CzSM4=;
 fh=mD9epQ3K6GAhWjgJAp6xksZxGN8f+e+RTn8jGe1Ak9Q=;
 b=DpjtWIiUUgX03ePqZQcwvoLP9j9g8mmk92BYcY9y9UkQLW04LlhTNfg3iGA5IRs4Z3
 S7CLKWBy8/UJOBvPP+2EuqOD2ZQ3uYNeBFOQp7sDI/6wifcWu6jOa0qnFWGdm0NmugaS
 FcgXpg5NrounQQ506An3u/K4YeNZNXA7GkwcK3lZS0M78ciQQlx9HovQPIjcYtCJGO8B
 5Pfh2U5gLBmtNvlblaITdN4rsEpkm1FKVX07V327JufRx81s4td+1I5pcTAXUUYgaVtn
 GkEPCTGs+kM8xegroJKfjWypHaoVTiune+iIltorh38AjDDlRf9yTP4tV8l8PL/Ygqwi
 Q5Sg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772679983; x=1773284783; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0U9WrbwztNegbUjYxWboo4sQNa8ZuN6iXyGby/CzSM4=;
 b=b3KNH/2HikA/Ef9rBvGgQ1+6BtLQzAk6+ZknglVx0TvEHnx+6lg8OwzM5ilHJNze8m
 KTAQcgHk/iBbvn2X4GI+g+zGGAZkiVMbnx8XqxUA4ovO5cCj6V3TDNRpAR2GDdvQ+1Ix
 +JnqbbfWkJzSP4dqLu5uokd6VEWYCAI1EHhQ75k6INqDlZyXfrgYmJSYaHr9hfjdGYeT
 OK1wuWd0cogV4oMkt2J5EACRQdITmZuRlQ5d0Mr86n4YxGMixtwKi1j0B3fu/BAVs21J
 /hXG1re0Q7YxqC/+q7Jr+PCNjuoKYH6nh0ENldEL6dlz/RguTEGBUZjt4HRMzG7EYVeq
 2nZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772679983; x=1773284783;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0U9WrbwztNegbUjYxWboo4sQNa8ZuN6iXyGby/CzSM4=;
 b=paZHBaKirCxyZKu4N9tv7D272A/VKCVQYjAe22hRB/+8V/jd64WfhCALSxZjFsWCEy
 bhKqZWAni0zW0iwfcN4knWZhLXih7IDt+5LDVnTnQSzU15hiw2o8OlyhXgkID0G7ep9P
 OQ9Ed6pggvYgqpm1AZtFWIoizQfipHDMOlOw/wWvkm318GPsFxjJ1ynIF7yvZRL3nYrL
 HS8XvAHvsGdeF+9JIuTocEz89sUfodwo6YCMstWoWogrHAVBEFn3vIReyfHfgw2oOlVb
 diMhgfG0Ek/+xZQCYszikWpoJsxo7KlPWVDbYEqSxRXWTczX34zP5btIMOKtMbcNPyO/
 8JOw==
X-Gm-Message-State: AOJu0YxtkcNiqA8yfWGHFlIDmI386P6KkgiX/x5QnjRrZecCocDl0u4P
 3T/noz6pae7ima4CvaEaMukAC09dalDmzKrJgClf4qi4A4jK9KafEkXjrgXkavzBtkTOjoGL4lK
 URRZOhNWnIDMGrdvk0D7z5oIQQ4ZxaLkABt/9
X-Gm-Gg: ATEYQzykR7HTjk4VH0Oz3PZX18KLhi+2gX/zDFZUys8NJFbeue6tFu4tqMKAPucDtkI
 eTeA8cNV4Xr1n5E6xcdb8XI2nBz6MG1B3YGUCUUD/GQqxflDsfiHx7KW6BHW9sMrgHQxFseKYTt
 i5K9JhLCoRcrRfJx+lZ0eZX+VL8F+uknJfYxlOV0Y36LRC38tUPT8XLcLvL0+OXIOe6yuMwJiNv
 dbqXVWObOnNbYj8k3bYQH0o7h32M9vNn0tjC5Sa7G3h4JefV8HORlv2XA1rCgve6bPl4+plz5zj
 uh5RGBL5
X-Received: by 2002:a05:6830:2112:b0:7c7:6558:277a with SMTP id
 46e09a7af769-7d6d115f0a3mr2724225a34.15.1772679983545; Wed, 04 Mar 2026
 19:06:23 -0800 (PST)
MIME-Version: 1.0
From: Sune Brian <briansune@gmail.com>
Date: Thu, 5 Mar 2026 11:06:12 +0800
X-Gm-Features: AaiRm50FgPw3Wm2k9oLeXwnJtUOe-0TUuEY4prgs_Xjl-J0C_i56juEnSC7QlcI
Message-ID: <CAN7C2SBrPb6hY_tJMioS4uWs=uZ2dC-0Qrx9C=_M1ht5hJGRgw@mail.gmail.com>
Subject: [BUG] Latest GEN5 socfpga handoff python script sanity issue
To: U-Boot Mailing List <u-boot@lists.denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>
Cc: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>
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

Dear all,

Issue:
Current handoff script generated files show missing behavior.
When using two IIC to FPGA "pinmux_config.h" shows
1, /* I2C3USEFPGA */
1, /* I2C2USEFPGA */

However after SPL under uboot simply reading via md.l shows
0xFFD08728 is not set.
Based on cv_5_HPS_tech_ref.pdf register 0xFFD08724 is properly
set to 1.

Possible test and run:
Even manually modifying the pinmux_config.h
0, /* I2C3USEFPGA */
0, /* I2C2USEFPGA */
still introduces 0xFFD08724 set to 1.

Based on the above situation:
distro or kernel basically fail to communicate the missing setup bus.
Manually set under uboot command can resolve the kernel bus issue.

Not much data on conversion and format of iocsr_config.h from hiof so
cannot fix this on my side.

Thanks,
Brian
