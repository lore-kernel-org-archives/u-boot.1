Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745E0C88E59
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 13:27:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36DAA80E8B;
	Sat, 12 Sep 2026 13:27:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ekHHpVBiiE8M; Sat, 12 Sep 2026 13:27:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 493E380E82
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789219636;
	b=tSxpo/U4ifgXIvwLedJWi0yVSncLLEYjhosTLosmiW53lCXY9NL7p8g2j8ZIzNEOHIQg
	 BEslaB4G6npHCdBsZxqSuTfsKw6OcVEBpnv/n0L7TNLVOVLLvrTTj3/hPIw8yftdznL+X
	 UAUZejmEp07r2iviGMiOdrcNKtLc/HcexX+acCrnWjhcCj8lmPZzJvMscGiP9eVANTesA
	 D1YrR7K3cJActO1cYTYjrm5SBJtZg+JBgW89aVTFhwC/B/YTWQGOTPUzIYg7mD7AjvWsM
	 k841tQXWJOpQx2L5sJ0Jlr2Ukhs4v6vFSX2jKi66FraQlDa7YZvbZ5Rw8DLFWFRbv6Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789219636;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VoOfnuVu4wjN+6D1VsqKMqfgu1WpQjlXeHLsIZwJlpI=;
	b=WQQUKtweAeS2ni4972zFF32QLtyTOpriUvJvmOTq947wwjObICBdsJpnKAkZsG+45CrE
	 OwV2DR31c5GcpHNWQSfkz85fT9N9H2KsFv1Is6mItonaHjRd2XEwy/Hk4vQs7MqLEHSR2
	 VxWD3Es+pDhYINCI2jMdDqWw95VsPj4d+69ZSsWqRfYbPUPBJ5rDNaBAHfwNyTJpCkcjE
	 CQ/nwYFYwU7pBYYpw7h+OEDPdUEKniyWZxxt7sS6MvazemTMWxAtF3LMfzlsaO9TYiXpH
	 TO6bqWUi8uro5bUz1NufUtmbjX/qDwPmAeS4x7WFOCEk+2haLwBb/SQeF08cNA6aWgQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789219636;
	bh=VoOfnuVu4wjN+6D1VsqKMqfgu1WpQjlXeHLsIZwJlpI=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vQS7Yvk/aAkts08vus2PzQp8tbEZuCgIyJ1i3x6OMTIaScCwBIe/xbcwLVpuesVn0
	 Xs8op5eg+t7Dz4ZtSSXalvz3Pyxj6/UfhZ9tR0q14UTngTWP8fmoBEpLDmj0VfybB3
	 YCNyYPICkkkW8D+YDuNCXI9yMcJSDvP/kGdIyX+IcRPCj58PtU0deFsqawbSioFiWz
	 NE7R9NsDaBZ8mkqrn75h1WREX5kGvbEiZnfm3ZDtx2CA7i4LOF/yHwqywDXZhk3EIb
	 VryX2JGk2hxReBfGiS7aicCb9qNAm4kkJNhec2l7om82j2ek2DZNPb0IHkvtLmOtOi
	 IVJwk0msRXN6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 493E380E82;
	Sat, 12 Sep 2026 13:27:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EEB0E32F
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 07:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D513C400E4
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 07:16:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F0PMkOS9-QF0 for <u-boot@lists.u-boot-project.org>;
 Sat, 12 Sep 2026 07:16:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 88D4940076
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789197406;
 b=XTZrNrAKC1wCYzZQtnrgFQjfB1SwLZvav7JIDW/lAcTZkeSp+4caaAZ5lzutuYxZ/1In
 kcnf6H/5SJ1huk8xYs/BTUyG0Njge7EhVnP4Z1DgAXh028FTvm26H7/0Y88BnBRQDNNVo
 5iqAVHb7193nlenwXokdWervNXMnByC1kxgX/FZh08wvlz3X0x3BFVqOpSgBKpzCMp5sH
 h2zKP2i5djTptUsrZfWaGii0d/YDJ+NZ52evOX0COuNMC/RQWDzAHqMM/m09ztQoUn71i
 YX4WiJElO+ys/DwxhYBeJ1p0RPTF3tCVrSZP0BS50voanDRk1vPuaV9kHf/ec9VPE1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789197406;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Content-Type;
 bh=VoOfnuVu4wjN+6D1VsqKMqfgu1WpQjlXeHLsIZwJlpI=;
 b=pgxYeeiVIy70f6IxU+N59PMYBs23iag/RTkNvTOz69vZ2EZ/5yGBxfbIiVXKMe2yCJ5/
 Mt8hZi6C/o84qGMqU0o3wdAZf9x5F7bq1O0vjuBI+khLPsPg0uaUQ5gmExINchJLLRTAa
 4lZ/T7QO7rexkVK7MuPaR/QECbefGOj0w9AnhVR9LA3/lF8OwggTGaYBUQXtZN6G54cDr
 9Iuf0dj63nLyyEWmG6KVZ17WDP2o0lMvyJiLECeynacmQOl4pn/1d7D9hsa5ugaEJjNsS
 M2gnRVCLXfQL9onX02HEFfgPhA3GR86MV8oFHEoaSDniBFN1I6b/q9U/7Jb/JlpBBlg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sVTrKXeO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=jacco.braat@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sVTrKXeO
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 88D4940076
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 07:16:44 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a99c5de614so889678a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 12 Sep 2026 00:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789197403; cv=none;
 d=google.com; s=arc-20260327;
 b=rwJZMSoB1oCdzzYL4bA6qP4jrHQhfJzNcBu5ZwTYlub26kHDTZeKvY3FpsoX0x6YS9
 u7ssV2yafXk+7bPH+DsoRXumGwaVOsJGsm0hOqH05DYpk/dFJKEvFu7p+4G7kbyD+/dJ
 8woi1osxlGnrWAYP15K7Jlll+Aw3nYEhnDLK8n6X29lC3gd8qilQ0+cvJD74BEUKIbwY
 ASbs6KwBLeSaM2iyq+qOpt7ixq+k7Xr2SjY2yss1oys+xqPd/pyPsg0HCareaRNdojoL
 5xNMKur2I07SayRScgm6MBGtLAdH2jMyshQY3ee7A5a8Ai823USm+COe4LmyQiJ6M6yg
 BFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=VoOfnuVu4wjN+6D1VsqKMqfgu1WpQjlXeHLsIZwJlpI=;
 fh=UPNS4HXYeIypNL+s9tL6UKBnRLDlxVjvSkHwqhb8LsE=;
 b=ewXoYW6ODWj4uKW36yJxqsz4eJCUXhSEzxrhVa4PjVyqMH7G7a53T8DKPvnrP+83WQ
 QV6PvfUZBu9YvwZZ+QgMBVqub8dGhQm71UmM/qI8Kv3KPLZ7bqP8DHBu+VtyoqFLDoqL
 01mVqCUqC2eqfnSqDdGBuWPF826/GcrXR53L8UFFdQDxcXYnrZQtDuWXW79BhWdhgxFP
 SR8wuXx+0niY/2RJ6c3/yn52G5oY4XFJtQiNXv36VzKFPlqw3RfDTwcV/XFVemZAcQ+e
 Nrm3bvtfUU5e3JV+gvbS+64yjUAcfDseApGaI27k/A7eJE2RhnTqN0ykSzXzC5Ncoj5C
 tEJQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789197403; x=1789802203;
 darn=lists.u-boot-project.org; 
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VoOfnuVu4wjN+6D1VsqKMqfgu1WpQjlXeHLsIZwJlpI=;
 b=sVTrKXeOdPFBEgtqKv3udiomXAnsaPbrQlZl26Swc/Quy8ewRCNWFYJDQbhjIHOcpI
 scEgiL6EscZ15UFkYQsV5o0y0CerzxaVhC0J9bwpkPIBt5+dwAy5qqRUH0lsXS62YeA6
 xdlt7svKlaVh3EbeTl4YNXFit+IoSYuSUb98LEl0uYQJHee+7/2ihjs3O7ty3ZAbBxpz
 LsihoBxy8rRivWavgnTQv/4uQaDOnjY0ob9/Kf3O43nHR+AcZHMsFgFG68Jdz3Cu6igD
 7BLWEp/L6RFD4SvKaNpk8WwJapAzWvy4sRkPvvwH07m362htU5zASv5OHjm1FdHk4J3x
 D+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789197403; x=1789802203;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VoOfnuVu4wjN+6D1VsqKMqfgu1WpQjlXeHLsIZwJlpI=;
 b=lcfMzoIVHQcMZOVGsVBEEmhl4+UXmPMZ9hl+gJjnkEBR5Hr6AG3kylnPbY01eL3l6A
 SDEamBTXFrLjIajhHL0o3ZyIRfLUdVljJ5oGhD9AFTOFBi54qqBz8g2JyjjULzrqn6H4
 IzJ0RjZtDEP8+O97D5kLT8+7TMXD3jOfvfrk+sEfAcoGqkbDEw+WRBMkeAJ58fQkbHiG
 XCVkykXUDI14l+4puj39uMPTj28yjNpkXIDeeybWPVvLJoIWXnwWrHPP9/NEkzBCj5Yz
 dCNmNE0/Shs82OztBFdbAejN50Ofd/Aci9dGBl12p09ukZ6ECZjW+HFS5Zy4ZUZjQFHW
 hsqg==
X-Gm-Message-State: AFuF++kQBQ1X62CtlYQbonu27Din/DVtqYz2oZIFsndR4OeOwR0wnZ0Y
 f2wyfO99q9JRrI+rEZ34ZMx/fTbQQl4vdadXr/Fr62DHYqoDeuE5tc0PoR7crpZovuNi3YDuvzJ
 xZrAPzZyXZJag7p0pEycLZWG9nPojwT3NeJNu
X-Gm-Gg: AYBFou0DkbR7/9XzPKpJO+/TeMgWjL1utlXAIJISrlPNmxD4qX1wuyeX4JyJlWIQuEF
 vuQYkfEWE5R7tFm+EFr29GrPNJkf/OrGNrQoTamfDAXOeZr5AahVJ+0cMz10l1f3H6Zz+yLbjhe
 8US3bLKamvWe0Junn55JD3cY5AAetXjOYqc7JNTCn1nkmdn0trUf7xyT3FVxfE6tnJY9Mnynn7N
 AG4pFixBMgGgfV+cd6v6Tx6lL/+lH16NVfTJHPKyJNv5zJvehmleVO4CwmHKvcbwR+ftOfkvORk
 RdOHAuhlPSmmKld17s5eO/nM7gL8nvfStC+58vhd1cb6Aj7XAK4hSneko1o9ygLJHqtj
X-Received: by 2002:a05:6402:5412:b0:6a3:e813:8457 with SMTP id
 4fb4d7f45d1cf-6a9b5695482mr7202430a12.12.1789197402700; Sat, 12 Sep 2026
 00:16:42 -0700 (PDT)
MIME-Version: 1.0
From: Jacco Braat <jacco.braat@gmail.com>
Date: Sat, 12 Sep 2026 09:16:31 +0200
X-Gm-Features: AcwNN1XzYqanRDPLXeanW5PznwNkM4JzhB8mYnBn1_Vf6MWFtz3_I3xEkbHz3jk
Message-ID: <CAMkwsPYxXK4o7C9Sxj+D8wBPNsdVyqekMPZznha_BtW7ChcvTA@mail.gmail.com>
Subject: pci-uclass.c not working for second device on 88W9098
To: u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="0000000000009efeaa065b43fb38"
X-Mailman-Approved-At: Sat, 12 Sep 2026 13:27:13 +0000
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

--0000000000009efeaa065b43fb38
Content-Type: text/plain; charset="UTF-8"

Hello,

in drivers/pci/pci-uclass.c there is an optimization introduced with
commit fbde868 that breaks discovery of the second network device on a
88W9098 Murata 1XL module.

int pci_bind_bus_devices(struct udevice *bus)
{
...
if (only_one_child(bus) && (PCI_DEV(bdf) > 0))
  continue;

With this check active device 1.0.1 is never reached.

=> pci 1 long
Scanning PCI devices on bus 1

Found PCI device 01.00.00:
  vendor ID =                   0x1b4b
  device ID =                   0x2b43
  command register ID =         0x0006
  status register =             0x0010
  revision ID =                 0x03
  class code =                  0x02 (Network controller)
  sub class code =              0x00
  programming interface =       0x00
  cache line =                  0x08
  latency time =                0x00
  header type =                 0x80
  BIST =                        0x00
  base address 0 =              0x4000000c
  base address 1 =              0x00000000
  base address 2 =              0x4010000c
  base address 3 =              0x00000000
  base address 4 =              0x4012000c
  base address 5 =              0x00000000
  cardBus CIS pointer =         0x00000000
  sub system vendor ID =        0x1b4b
  sub system ID =               0x2b43
  expansion ROM base address =  0x00000000
  interrupt line =              0xff
  interrupt pin =               0x01
  min Grant =                   0x00
  max Latency =                 0x00

Found PCI device 01.00.01:
  vendor ID =                   0x1b4b
  device ID =                   0x2b44
  command register ID =         0x0006
  status register =             0x0010
  revision ID =                 0x03
  class code =                  0x02 (Network controller)
  sub class code =              0x00
  programming interface =       0x00
  cache line =                  0x08
  latency time =                0x00
  header type =                 0x80
  BIST =                        0x00
  base address 0 =              0x4020000c
  base address 1 =              0x00000000
  base address 2 =              0x40300004
  base address 3 =              0x00000000
  base address 4 =              0x4032000c
  base address 5 =              0x00000000
  cardBus CIS pointer =         0x00000000
  sub system vendor ID =        0x1b4b
  sub system ID =               0x2b44
  expansion ROM base address =  0x00000000
  interrupt line =              0xff
  interrupt pin =               0x02
  min Grant =                   0x00
  max Latency =                 0x00

Without preparation in u-boot the Linux kernel will detect the device, but
the driver fails to create the network interfaces.

The wifi card is using a M2 slot on a Layerscape LS1028a based board.

Best regards,
Jacco Braat

--0000000000009efeaa065b43fb38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj48YnI+PC9kaXY+PGRpdj5IZWxsbyw8L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2PmluIGRyaXZlcnMvcGNpL3BjaS11Y2xhc3MuYyB0aGVyZSBpcyBhbiBvcHRpbWl6
YXRpb24gaW50cm9kdWNlZCB3aXRoIGNvbW1pdMKgZmJkZTg2OCB0aGF0IGJyZWFrcyBkaXNjb3Zl
cnkgb2YgdGhlIHNlY29uZCBuZXR3b3JrIGRldmljZSBvbiBhIDg4VzkwOTggTXVyYXRhIDFYTCBt
b2R1bGUuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5pbnQgcGNpX2JpbmRfYnVzX2RldmljZXMo
c3RydWN0IHVkZXZpY2UgKmJ1cyk8YnI+ezxicj4uLi48YnI+aWYgKG9ubHlfb25lX2NoaWxkKGJ1
cykgJmFtcDsmYW1wOyAoUENJX0RFVihiZGYpICZndDsgMCkpPGJyPsKgIGNvbnRpbnVlOzxicj48
YnI+PC9kaXY+PGRpdj48L2Rpdj48ZGl2PldpdGggdGhpcyBjaGVjayBhY3RpdmUgZGV2aWNlIDEu
MC4xIGlzIG5ldmVyIHJlYWNoZWQuwqDCoDwvZGl2PjxkaXY+PGJyPj0mZ3Q7IHBjaSAxIGxvbmc8
YnI+U2Nhbm5pbmcgUENJIGRldmljZXMgb24gYnVzIDE8YnI+PGJyPkZvdW5kIFBDSSBkZXZpY2Ug
MDEuMDAuMDA6PGJyPsKgIHZlbmRvciBJRCA9IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4
MWI0Yjxicj7CoCBkZXZpY2UgSUQgPSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAweDJiNDM8
YnI+wqAgY29tbWFuZCByZWdpc3RlciBJRCA9IMKgIMKgIMKgIMKgIDB4MDAwNjxicj7CoCBzdGF0
dXMgcmVnaXN0ZXIgPSDCoCDCoCDCoCDCoCDCoCDCoCAweDAwMTA8YnI+wqAgcmV2aXNpb24gSUQg
PSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAweDAzPGJyPsKgIGNsYXNzIGNvZGUgPSDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoDB4MDIgKE5ldHdvcmsgY29udHJvbGxlcik8YnI+wqAgc3ViIGNs
YXNzIGNvZGUgPSDCoCDCoCDCoCDCoCDCoCDCoCDCoDB4MDA8YnI+wqAgcHJvZ3JhbW1pbmcgaW50
ZXJmYWNlID0gwqAgwqAgwqAgMHgwMDxicj7CoCBjYWNoZSBsaW5lID0gwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAweDA4PGJyPsKgIGxhdGVuY3kgdGltZSA9IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgMHgwMDxicj7CoCBoZWFkZXIgdHlwZSA9IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4ODA8
YnI+wqAgQklTVCA9IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMHgwMDxicj7C
oCBiYXNlIGFkZHJlc3MgMCA9IMKgIMKgIMKgIMKgIMKgIMKgIMKgMHg0MDAwMDAwYzxicj7CoCBi
YXNlIGFkZHJlc3MgMSA9IMKgIMKgIMKgIMKgIMKgIMKgIMKgMHgwMDAwMDAwMDxicj7CoCBiYXNl
IGFkZHJlc3MgMiA9IMKgIMKgIMKgIMKgIMKgIMKgIMKgMHg0MDEwMDAwYzxicj7CoCBiYXNlIGFk
ZHJlc3MgMyA9IMKgIMKgIMKgIMKgIMKgIMKgIMKgMHgwMDAwMDAwMDxicj7CoCBiYXNlIGFkZHJl
c3MgNCA9IMKgIMKgIMKgIMKgIMKgIMKgIMKgMHg0MDEyMDAwYzxicj7CoCBiYXNlIGFkZHJlc3Mg
NSA9IMKgIMKgIMKgIMKgIMKgIMKgIMKgMHgwMDAwMDAwMDxicj7CoCBjYXJkQnVzIENJUyBwb2lu
dGVyID0gwqAgwqAgwqAgwqAgMHgwMDAwMDAwMDxicj7CoCBzdWIgc3lzdGVtIHZlbmRvciBJRCA9
IMKgIMKgIMKgIMKgMHgxYjRiPGJyPsKgIHN1YiBzeXN0ZW0gSUQgPSDCoCDCoCDCoCDCoCDCoCDC
oCDCoCAweDJiNDM8YnI+wqAgZXhwYW5zaW9uIFJPTSBiYXNlIGFkZHJlc3MgPSDCoDB4MDAwMDAw
MDA8YnI+wqAgaW50ZXJydXB0IGxpbmUgPSDCoCDCoCDCoCDCoCDCoCDCoCDCoDB4ZmY8YnI+wqAg
aW50ZXJydXB0IHBpbiA9IMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4MDE8YnI+wqAgbWluIEdyYW50
ID0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgwMDxicj7CoCBtYXggTGF0ZW5jeSA9IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4MDA8YnI+PGJyPkZvdW5kIFBDSSBkZXZpY2UgMDEuMDAu
MDE6PGJyPsKgIHZlbmRvciBJRCA9IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4MWI0Yjxi
cj7CoCBkZXZpY2UgSUQgPSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAweDJiNDQ8YnI+wqAg
Y29tbWFuZCByZWdpc3RlciBJRCA9IMKgIMKgIMKgIMKgIDB4MDAwNjxicj7CoCBzdGF0dXMgcmVn
aXN0ZXIgPSDCoCDCoCDCoCDCoCDCoCDCoCAweDAwMTA8YnI+wqAgcmV2aXNpb24gSUQgPSDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAweDAzPGJyPsKgIGNsYXNzIGNvZGUgPSDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDB4MDIgKE5ldHdvcmsgY29udHJvbGxlcik8YnI+wqAgc3ViIGNsYXNzIGNv
ZGUgPSDCoCDCoCDCoCDCoCDCoCDCoCDCoDB4MDA8YnI+wqAgcHJvZ3JhbW1pbmcgaW50ZXJmYWNl
ID0gwqAgwqAgwqAgMHgwMDxicj7CoCBjYWNoZSBsaW5lID0gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAweDA4PGJyPsKgIGxhdGVuY3kgdGltZSA9IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMHgw
MDxicj7CoCBoZWFkZXIgdHlwZSA9IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4ODA8YnI+wqAg
QklTVCA9IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMHgwMDxicj7CoCBiYXNl
IGFkZHJlc3MgMCA9IMKgIMKgIMKgIMKgIMKgIMKgIMKgMHg0MDIwMDAwYzxicj7CoCBiYXNlIGFk
ZHJlc3MgMSA9IMKgIMKgIMKgIMKgIMKgIMKgIMKgMHgwMDAwMDAwMDxicj7CoCBiYXNlIGFkZHJl
c3MgMiA9IMKgIMKgIMKgIMKgIMKgIMKgIMKgMHg0MDMwMDAwNDxicj7CoCBiYXNlIGFkZHJlc3Mg
MyA9IMKgIMKgIMKgIMKgIMKgIMKgIMKgMHgwMDAwMDAwMDxicj7CoCBiYXNlIGFkZHJlc3MgNCA9
IMKgIMKgIMKgIMKgIMKgIMKgIMKgMHg0MDMyMDAwYzxicj7CoCBiYXNlIGFkZHJlc3MgNSA9IMKg
IMKgIMKgIMKgIMKgIMKgIMKgMHgwMDAwMDAwMDxicj7CoCBjYXJkQnVzIENJUyBwb2ludGVyID0g
wqAgwqAgwqAgwqAgMHgwMDAwMDAwMDxicj7CoCBzdWIgc3lzdGVtIHZlbmRvciBJRCA9IMKgIMKg
IMKgIMKgMHgxYjRiPGJyPsKgIHN1YiBzeXN0ZW0gSUQgPSDCoCDCoCDCoCDCoCDCoCDCoCDCoCAw
eDJiNDQ8YnI+wqAgZXhwYW5zaW9uIFJPTSBiYXNlIGFkZHJlc3MgPSDCoDB4MDAwMDAwMDA8YnI+
wqAgaW50ZXJydXB0IGxpbmUgPSDCoCDCoCDCoCDCoCDCoCDCoCDCoDB4ZmY8YnI+wqAgaW50ZXJy
dXB0IHBpbiA9IMKgIMKgIMKgIMKgIMKgIMKgIMKgIDB4MDI8YnI+wqAgbWluIEdyYW50ID0gwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMHgwMDxicj7CoCBtYXggTGF0ZW5jeSA9IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIDB4MDA8YnI+PGJyPjwvZGl2PjxkaXY+V2l0aG91dCBwcmVwYXJhdGlv
biBpbiB1LWJvb3QgdGhlIExpbnV4IGtlcm5lbCB3aWxsIGRldGVjdCB0aGUgZGV2aWNlLCBidXQg
dGhlIGRyaXZlciBmYWlscyB0byBjcmVhdGUgdGhlIG5ldHdvcmvCoGludGVyZmFjZXMuPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5UaGUgd2lmaSBjYXJkIGlzIHVzaW5nIGEgTTIgc2xvdCBvbiBh
IExheWVyc2NhcGUgTFMxMDI4YSBiYXNlZCBib2FyZC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PkJlc3QgcmVnYXJkcyw8L2Rpdj48ZGl2PkphY2NvIEJyYWF0PC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+DQo=
--0000000000009efeaa065b43fb38--
