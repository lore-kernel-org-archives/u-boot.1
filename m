Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5481AC55171
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 04:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1630D80DB8;
	Sun,  2 Aug 2026 04:35:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kudm-z17Mqvl; Sun,  2 Aug 2026 04:35:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B04BF80D8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785645334;
	bh=7rj2ykVmI6aLlWRq9jvpdWUIKr9EI0g5Y2J5+0giru0=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pkrGXkyDMOrGwjCvmKjGLsfWiGpqaDcdSIzdh9xNKo2IF+lUjrmHmGDVVzKZpXy3A
	 2y7QUSYvVNGH6iHKbQ8HC2bK6DiO55PTrtT0+QSJWGENpCGhORYq6dGOmI9HIoSEfP
	 W1Afw4RalrhpIwCVq5joG4hdzhfT+cYFcepROGR4BsC2Z6lTo1s836MtEYJrDBEOBg
	 fIhreOHLWdwcMBHnV0eQBoxC+66Wksv34LFN5UPPDWPXJHh7YyBdHa8R3xhBHhNAvJ
	 JqpLDDiAdHbR/xuANvomNFbdFmk1YBl7emTigLADZl0ug+4/Sr6Q/PQcFCuqEe8vPE
	 IVHeUCxavnGEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B04BF80D8B;
	Sun,  2 Aug 2026 04:35:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D8F2E389
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 02:14:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BEB6C4011A
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 02:14:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cCHRbMvTS9LN for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 02:14:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2c; helo=mail-vk1-xa2c.google.com;
 envelope-from=vicencb@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BB0E4400AA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BB0E4400AA
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BB0E4400AA
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 02:14:23 +0000 (UTC)
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-5c2c96286f0so1148457e0c.3
 for <u-boot@lists.u-boot-project.org>; Sat, 01 Aug 2026 19:14:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785636862; cv=none;
 d=google.com; s=arc-20260327;
 b=OrT4+SCSFCxCvf1bAJ2KJZk3UPZ0C9nRb4+Ykee7RPxS7OEToiHc1kFmp69eSsq/xC
 kqBA363k0JeG605yOsXRDuLxbC2gnRB0RJs6AzXOzwHdR6+zKOTuMurhIdHYSEguVuTX
 8y0+KrO/Eeqmq3IZ3SSNAYaxTMeKepSTXYv7hiJAK6sM6pWRe3Xg9cnCmjPYiY7bz85b
 S50KT36lbAKbMAD4X3z5tEem6MC2cUTQYJnj3u6WRQ3o6Zk6+W7Wc325MM7NcaMBm10r
 HHX4TageBAhGOGytazVoPj6C0YuZ26ZRhHbCDBzVMMWMaanmfC3aefDBR3kc3bdMB1x2
 tO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=7rj2ykVmI6aLlWRq9jvpdWUIKr9EI0g5Y2J5+0giru0=;
 fh=UPNS4HXYeIypNL+s9tL6UKBnRLDlxVjvSkHwqhb8LsE=;
 b=BxAF7+8Vkd0RxKLOndsxN7kdYmfzil1r9mf8vj0srFVsclzGuyPg/3rqh345U6ub0d
 U3L6blEHg3wov76vlNA66PJq5Bm7ZXZSq3W/CjSY/Mo8HP6h0X8k6/w0RD6BKUjLzodR
 5lzMK0eElgAyS/SViV0JyDSN9mYUPyDcUp72jjonj5CC31o5BimTV4WwO/UWY45tdOUK
 GLvpKsEYW1gPxtwGLIi+u3JHJmzuPm5CZx5ACRSvVn/0/jXzQXYZxsAi2TKQuZhYU+BR
 HkRuRKVOHM09N64zlz16WSpi37RcKacXdNftF/UrEnvdnNVmFoBjVHQLue/KMEal5YGJ
 49gg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785636862; x=1786241662;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7rj2ykVmI6aLlWRq9jvpdWUIKr9EI0g5Y2J5+0giru0=;
 b=I8LJF1VWIgiDW2Y1zPTyFRvORZcjmPY4xKKGfay0H67svOx9EfLXlEuNbPiOwELEt5
 cZ1GbFiC8IBVhcPEB8DrkkMQxrsmZpLKbD5nKnRnZziTmfmKHizStTRUn5zpRTtVoRuc
 xMvVjezb9nCLarb4ukAoYqfhXcB6827zcvUC2nDq6g362mV4Yw3WreGkJtTfj6P3w9jd
 eVb5YSyK8pAtVNy+NRZr58H3nJzxZLwU6B3sPNGA6aZP6gGBLO8f2B7H+0WkASEcu7Zx
 b/8vjwjFuM4coiD617+Hjbeyktyxa9LaHHbelD8MYToAE99iDcIfK70ucSZWethR4Ihq
 WYxw==
X-Gm-Message-State: AOJu0YwonOfbc/3W4EDr7hh+d6ZlRmCG65Nn4xDsp2n3vojPSmbzkbS2
 qbHwAl5CiYbdcuT4L1QKdnZvJUKhH+K2ahPpkaOxAAy8sEAhyvS+W0DjHKVLH+OALYdjambayLt
 nssJ2cT99cy0viDqs01PVnZqhM/MhCNlJOvW+
X-Gm-Gg: AR+sD13wrARksqjjomtXliuYbojSvU2ZtVB+Z08Wg9V6jhGFXfZ7ndDP2j/+IRevf1k
 qJyoaWbGv91QhGzL09O9k0dKLO45WPb47fcuARk0Zc6fic2DqMBbH7BWmpcFhEvCSVebKT+dM1S
 iHpNh1x2olhWj4JZo0firtg268pdDBzLASZKQjYE88IYoKmM2yiz4AAUGtL8og8LEx94nD6X79W
 pC3hlk8pSBlCdbTTZ5TS5dP636HXfSuPPtTo1EvSNSQ842mlL0WREgP3pv+SRQgbZAxTfxb9JlD
 H4hij7CrtJkM3KaityyZO+fNLLlMgF7oDJ5R17o1SsE+stO7HtttyCi1CPyvcBU25x4h1GOxH9C
 s1Q==
X-Received: by 2002:a05:6122:4890:b0:5bf:a6dc:e631 with SMTP id
 71dfb90a1353d-5c38787e0a8mr1745268e0c.14.1785636862282; Sat, 01 Aug 2026
 19:14:22 -0700 (PDT)
MIME-Version: 1.0
From: Vicente Bergas <vicencb@gmail.com>
Date: Sun, 2 Aug 2026 04:14:10 +0200
X-Gm-Features: AUfX_myDRhNzZzhawkqDPWFl23DIEr7lxuQFdc0Y9YZVRoIWWI2t1vhlgVN2dXU
Message-ID: <CAAMcf8A2fkH41UP9jsJZSaPS2PUaoB_CNT5g4E4KXG0thmUvOQ@mail.gmail.com>
Subject: Issue found when porting to new device.
To: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 02 Aug 2026 04:35:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785636862; x=1786241662;
 darn=lists.u-boot-project.org; 
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7rj2ykVmI6aLlWRq9jvpdWUIKr9EI0g5Y2J5+0giru0=;
 b=nC+SjOtl20hHHq3tDcnqNeMDt9xtjn72bPl1Zy3+SptZ1achXVXvcp2ADMGBz9No1A
 xA4Z2AuXha2uiTqdvKyuhS9urfH05LdOIhyaLKuGxzi5LF4r8IKh0yCNjINhAfr3UUXV
 83Yo79ykF+pjZpHgctvVW9stSj7wLwlfU6swFRz31LczAAORqdeH785JALW32TMUQ0tV
 ykHnRe7C3zDmNwb/8JyMd8ywGMMYrJPHcXdiukrRTQKycVX1CxSULyEaksJXzw3iA4e1
 XAfobtIg2B7/XWgVH3oEM/G6Jxe8x+elUGqEdvA/JJZ8IkOHSuqOP5HHSB1L24+Bwd/4
 zVvw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nC+SjOtl
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi,
i am porting u-boot to a new device:
https://handhelds.wiki/R36S_Handheld_Wiki

Given the similarity with ODROID_GO2, i've based my efforts on it and
all goes fine up to the very last step: jumping from u-boot to linux.

In the file arch/arm/cpu/armv8/transition.S there is a call to
armv8_switch_to_el2_m which is supposed to jump into linux, but it
doesn't.

I've added some debug prints around it (see patch below) and it prints
the first message:
"before switch from EL3 to EL2"
but it does not print either of the messages after.

As another test, i've tried to replace
armv8_switch_to_el2_m x4, x5, x6
to
br x4
and then it indeed switches to linux, but then linux crashes, prints a
trace and reboots, that is, it doesn't like running from EL3.

Please, can somebody help here?

Regards,
  Vicente.

--- a/arch/arm/include/asm/macro.h
+++ b/arch/arm/include/asm/macro.h
@@ -209,6 +209,7 @@
     msr    spsr_el3, \tmp
     msr    elr_el3, \ep
     eret
+    b    2f

 1:
     /*
@@ -228,6 +229,7 @@
     msr    spsr_el3, \tmp
     msr     elr_el3, \ep
     eret
+2:
 .endm

 /*
--- a/arch/arm/cpu/armv8/transition.S
+++ b/arch/arm/cpu/armv8/transition.S
@@ -36,8 +36,46 @@
      * address saved in x4.
      */
     br x4
-1:    armv8_switch_to_el2_m x4, x5, x6
+1:
+
+    adr x8, msg_before
+    bl uart5_asciiz
+
+    adr x8, switch_to_el2_ok
+    armv8_switch_to_el2_m x8, x5, x6
+
+    adr x8, msg_aft_ko
+    bl uart5_asciiz
+
+switch_to_el2_ko:
+    b switch_to_el2_ko
+
+switch_to_el2_ok:
+    adr x8, msg_aft_ok
+    bl uart5_asciiz
+
+    br x4
+
+msg_before: .asciz "before switch from EL3 to EL2\n"
+msg_aft_ko: .asciz "switch to EL2 failed\n"
+msg_aft_ok: .asciz "now running in EL2\n"
 ENDPROC(armv8_switch_to_el2)
+
+ENTRY(uart5_asciiz)
+    mov  x10, #0x8000
+    movk x10, #0xFF17, lsl #16
+2:
+    ldrb w9, [x8]
+    cbnz w9, 3f
+    ret
+3:
+    add  x8, x8, #1
+4:
+    ldr  w11, [x10, #20] // [UART5_LSR]
+    tbz  w11, #5, 4b     // while (!trans_hold_reg_empty)
+    str  w9, [x10]       // [UART5_THR] <= *str++;
+    b    2b
+ENDPROC(uart5_asciiz)
 .popsection

 .pushsection .text.armv8_switch_to_el1, "ax"
