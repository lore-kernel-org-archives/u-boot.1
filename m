Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7406CC61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:50:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2ACDE60802;
	Thu, 27 Aug 2026 19:50:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vG3vyGpqn1jd; Thu, 27 Aug 2026 19:50:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860245;
	bh=pVQxkbCs0G/3WDJgN+YoSAuNrynl9xcIju5FL9HgUpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CivB4w54V07PJg1PynW76897MEEuvXIybwaO+oW4OCcBbgzdIKkWh06LjtH/gpji6
	 Dvcnq+/uoJ4i59aiKd+n0H459w+rX2ks//lyZ5JV0aFnkwBObr0HodwJfOqbCrxh/n
	 e5Tt+n/ZAcn7yrghC7b6PMohc1IEQdpNga8FiCTLzQA/Mo9HtxPCaDJkPCj/1EYzdG
	 o1yQks37O6NSH2eqfdDqV0oH5OWIcRQ3Z4/0ft1RN5hwaIMu+Z3zE2VxMsDcM8H8Im
	 blZs4idFZeQA1Bj95gWId2yAE62YDPlvryO38QUNRmUfzDPtSBu3dFifj7jPCIbDaF
	 ihaIYpWo8SFQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E46460823;
	Thu, 27 Aug 2026 19:50:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E660B105
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 17:35:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D8B50607D3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 17:35:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LTiXQGrFkfov for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 17:35:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=andrey.lalaev@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=APakiDEo
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D7393607B3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 17:35:44 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so101455e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 10:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787852142; x=1788456942;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pVQxkbCs0G/3WDJgN+YoSAuNrynl9xcIju5FL9HgUpI=;
 b=APakiDEoEB1OMPKOb6uQ2LWqQe9P77mYaAhKydzsup0tlwO3+h0QozoNMX0BzGLHwm
 uzxlwlfI0se9PqWba5JOObkbv08u/wFUvm1rFhqi78tmREFQCmltLhzVxjqZ0e/ytA7U
 jrdeKuumrvZEoTaPgjQ7xoeMUapD+K3isug6QWIJJQI7CDFh7SXy0dH7lQO2jrR3tUNp
 G0pA4vsMAuCi4uC5fulhJRLxrhTwOCwZ6TLjdR4d7whPmpkCfthTWBMMNfeAOPgdgFEl
 zDWoxuEsHAafBlHmcV5HuR2FnxrFRTzYLkjORTeOkr4FT2/ckpCWO9DLV/i7QoAyq9e5
 BAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787852142; x=1788456942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pVQxkbCs0G/3WDJgN+YoSAuNrynl9xcIju5FL9HgUpI=;
 b=b2rXBWDPoph5wf9hP6D4QWs3YUxCUi0D4gw0Z7h0CFfb9fhmjuuXaTBr1wgUDY5Hwo
 jk8F8wdXuuwZM3joSrS85SaHxgLOvtt+i7qjDqlmL7bv/o9+76m+/lwlnt6UErUiRdce
 rxkrL/cwwUtzQxHyPAzDywjQyFnw/EAuqzFlznWzMStUJS3ahYbyTMwz5YbJZcmH0eSd
 mzvhbp3CIGffjjkye0WN777z/aJKNWtrHFhq5kTpYcfKVEFdmJenggsv/7lVTEU1FIuM
 o02OagLYLpIwanaEbAUJoo5kV8MnNvFnVwysVgfI0QFupOUMVl+Z2EYyHZ28/gEjcCFl
 yP1Q==
X-Gm-Message-State: AFuF++mOC7MtK7dtRoS/yspagjBd//GbHc1/2pxlScZ4C0Swu+9MfAaf
 DNEVpt8/7X2+5plinFBoreR7VEiIqmNZv5EawSLJp6/MjJawwglDhlt3swzVo+Ba
X-Gm-Gg: AR+sD12ZqrNXenpkIcOHhkqqKa7MzQzUk3+/CyqPGN02UoIPbrq65pkIK/8n9eiOkAG
 hogvjlI2s/UolVaz6a7a6tIginbbqVV8oLpyUoxykSfXZguaI23r34+sNmW3ghnurqaCf3yhG8z
 4eYlF/1cvS0rYvj2VpQMaKqsaP+by5feeydnHfqDUi5pbsLkplL3tBG1SXq/vS8jo9lp4leH9GS
 OphrTIlGM1yntr/Y5J/+uSs3f2jkENKXv/ynSPEIZCqpdWwVRvPa/M7c+e6smrOcYH1GynOUWc0
 ZKFjd0hM/p6CHt4pWXzxII0xihSpyCJ1qPoHYV4dLXJdetuZoZEA6AEuT+9c/Eu1bU85nlsWA+c
 Yi0V6mUbiyHHhlL/XBCSPkGfPN/k0ZJ8IGIscCyxsAIlGXQesVnz4Xivwd8l7aedMbyJeuXSir7
 GYQxDLOLj55g+GrSye1LGodDb+XeoLwDzFnVUiXZoJp34s/EC7EKYTVoJk3BDm9+sHucWg7WjjM
 25bEK+Gb44EhGbAr2eb6XsKgnffIFx3E+H0hRx25f2ROLPTw4Ge8EWNWvayUu0xsY3qLH7ZhyDR
 yyQw2iuF+aSIUBvQdA==
X-Received: by 2002:a05:600c:3493:b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-49b91c4792bmr8470495e9.10.1787852142210; 
 Thu, 27 Aug 2026 10:35:42 -0700 (PDT)
Received: from thinkpad-p52.telekom.ip
 (2a02-8388-e6ca-5780-e161-768d-5c97-84d0.cable.dynamic.v6.surfer.at.
 [2a02:8388:e6ca:5780:e161:768d:5c97:84d0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b49610170sm140256155e9.6.2026.08.27.10.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 10:35:41 -0700 (PDT)
From: Andrei Lalaev <andrey.lalaev@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: guodong@riscstar.com, hfranco@baylibre.com, jh80.chung@samsung.com,
 junhui.liu@pigmoral.tech, leo.liang@sifive.com, lukma@denx.de, me@ziyao.cc,
 peng.fan@nxp.com, schwab@suse.de, seashell11234455@gmail.com,
 stefan.roese@mailbox.org, thomas.bonnefille@bootlin.com,
 tim609@andestech.com, trini@konsulko.com, zhuxu_ran@zohomail.com,
 andrey.lalaev@gmail.com
Subject: Re: [PATCH v3 4/7] riscv: milkv_duo: Use upstream devicetree
Date: Thu, 27 Aug 2026 19:35:40 +0200
Message-ID: <20260827173540.621755-1-andrey.lalaev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806-milkv-duo-upstream-dts-v3-4-917cf70a2337@zohomail.com>
References: <20260806-milkv-duo-upstream-dts-v3-4-917cf70a2337@zohomail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Aug 2026 19:50:39 +0000
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

Hi Zhuxu,

Thank you for your patches.

I am playing with Duo and Duo-256M and faced an interesting thing
regarding reserved-memory on these boards.

It looks like your patchset may cause a memory corruption
of U-Boot or coprocessor FW for Milk-V Duo.

DTS in U-Boot limits RAM to 63.25 MB:

  memory@80000000 {
          device_type = "memory";
          reg = <0x80000000 0x3f40000>;
  };

Because the last 0.75 MB (0xc0000) is reserved for coprocessor.
Kernel uses different approach by declaring all RAM and
relying on `reserved-memory` for coprocessor.

However, this doesn't work for U-Boot because it places its stack
and heap near the top of RAM, therefore region in the top of RAM
is not reserved. So coprocessor FW or U-Boot may be corrupted.

With your patches it also gives an ERROR during reserving (because the region
is already used by U-Boot itself):

  U-Boot 2026.10-rc3-00007-g8e48ce755361 (Aug 27 2026 - 18:53:59 +0200)milkv_duo

  DRAM:  64 MiB
  ERROR: reserving fdt memory region failed (addr=83f40000 size=c0000 flags=2): -17
  Core:  23 devices, 15 uclasses, devicetree: separate
  MMC:   mmc@4310000: 0
  Loading Environment from nowhere... OK
  In:    serial@4140000
  Out:   serial@4140000
  Err:   serial@4140000
  Net:
  Warning: ethernet@4070000 (eth0) using random MAC address - 0a:06:39:79:c7:ed
  eth0: ethernet@4070000

  milkv_duo# bdinfo
  boot_params = 0x0000000000000000
  DRAM bank   = 0x0000000000000000
  -> start    = 0x0000000080000000
  -> size     = 0x0000000004000000
     ...
  relocaddr   = 0x0000000083f73000
  reloc off   = 0x0000000003d73000
     ...
  fdt_blob    = 0x000000008372ec60
  lmb_dump_all:
   memory.count = 0x1
   memory[0]      [0x80000000-0x83ffffff], 0x4000000 bytes, flags: none
   reserved.count = 0x3
   reserved[0]    [0x80000000-0x8005ffff], 0x60000 bytes, flags: no-map
   reserved[1]    [0x8272b000-0x8272dfff], 0x3000 bytes, flags: no-notify, no-overwrite
   reserved[2]    [0x8272ec50-0x83ffffff], 0x18d13b0 bytes, flags: no-overwrite
  devicetree  = separate
     ...
  stack ptr   = 0x000000008372e980
  ram_top ptr = 0x0000000084000000
  malloc base = 0x0000000083733000
  boot hart   = 0x0000000000000000
  firmware fdt= 0x0000000080080000

  milkv_duo# meminfo
  DRAM:  64 MiB

  Region                Base          Size           End           Gap
  --------------------------------------------------------------------
  code              83f73000         8cc30      83fffc30
  malloc            83733000        840000      83f73000             0
  board_info        83732fb0            50      83733000             0
  global_data       83732e40           168      83732fa8             8
  devicetree        8372ec60          41da      83732e3a             6
  stack             8272ec50       1000000      8372ec50            10
  lmb               8272ec50             0      8272ec50             0
  lmb               8272b000          3c50      8272ec50             0
  lmb               80000000       272b000      8272b000             0
  free              80000000             0      80000000             0


Main branch with the original U-Boot DTS:
  U-Boot 2026.10-rc3-00001-g7cbe3e32b6b4 (Aug 27 2026 - 18:30:42 +0200)milkv_duo

  DRAM:  63.3 MiB
  Core:  22 devices, 15 uclasses, devicetree: separate
  MMC:   mmc@4310000: 0
  Loading Environment from nowhere... OK
  In:    serial@4140000
  Out:   serial@4140000
  Err:   serial@4140000
  Net:
  Warning: ethernet@4070000 (eth0) using random MAC address - 82:8a:04:d3:35:d0
  eth0: ethernet@4070000

  milkv_duo# bdinfo
  boot_params = 0x0000000000000000
  DRAM bank   = 0x0000000000000000
  -> start    = 0x0000000080000000
  -> size     = 0x0000000003f40000
     ...
  relocaddr   = 0x0000000083eb3000
  reloc off   = 0x0000000003cb3000
     ...
  fdt_blob    = 0x00000000836705e0
  lmb_dump_all:
   memory.count = 0x1
   memory[0]      [0x80000000-0x83f3ffff], 0x3f40000 bytes, flags: none
   reserved.count = 0x3
   reserved[0]    [0x80000000-0x8005ffff], 0x60000 bytes, flags: no-map
   reserved[1]    [0x8266d000-0x8266ffff], 0x3000 bytes, flags: no-notify, no-overwrite
   reserved[2]    [0x826705d0-0x83f3ffff], 0x18cfa30 bytes, flags: no-overwrite
  devicetree  = separate
     ...
  stack ptr   = 0x0000000083670300
  ram_top ptr = 0x0000000083f40000
  malloc base = 0x0000000083673000
  boot hart   = 0x0000000000000000
  firmware fdt= 0x0000000080080000


I'm not sure of a better solution here other than limiting the RAM node
to exclude the coprocessor region.

Best regards,
Andrei Lalaev
