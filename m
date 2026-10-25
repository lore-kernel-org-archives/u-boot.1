Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B42606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 04:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aVbN5Xyh;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hJucMWLi
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60A6B40685;
	Sun, 25 Oct 2026 04:47:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bni47DdL-M0U; Sun, 25 Oct 2026 04:47:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 90BB64066C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792903643;
	b=alnMCp4vb7mEhjakMW1Oyn8+E3DxclGxvs7SPjXuDLouuiLqHC/DEEzPL0H1QSQFsdZr
	 DY/YmjHsyQbLWKlV1I48xziQ+HD3ngGgwqa4SOwfBza4doPnbH6zzeNJ5DRyXJhLJABLm
	 /hhr/B70BJQmalVZ2ik2mknP0GjpwuQt/pcvhkP43mvP4m8OmgTy37yanTeuw87UgYpNW
	 1usQ2T7wYuSqUtBIyRMUbLvluLkjB3B4EAEEo6Jz0OOEPjnwFYMmBgC5vqkQoeqJzztoi
	 fohnS07l3ndQwCeDAflao35JM4bhboZzWGTtl1/wlYumdC7vQYSIT3jy3UWQORtGVag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792903643;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Hq8kSJLbnL/rws3xczNEUy1qD3UM0OZc1XXBgt62AXI=;
	b=qzDX2Rk5QwiX7VWtKp85qzGKqKWTC7Pd5gZZu617DM2PI/2fQh8FoqiKPLNYAcbh0zVH
	 pWwMoqqosAHIE2EmzVzKFrTgsofYEAvj+5cs01o77vhVyXpRT5U5RRyjuHqRHUV8+dojI
	 7HfpBWe7FezfVAKr9juXBISZVE9rp+sdyEaN9hHSlsrGXTUnoad08rcDfHvwheq+W8NQD
	 PkMBN87MjxPAEgWR4vMlBQH0H9ByHcCmej6e4O/WiATDApd8glxlmQCgViEeAiJVQItfL
	 gjVFi53XYjHPNkCkeQxzoUjx36OxFwQq1pmYqQOyVGA6WWPuyMXxzi06+EDMJFbizeg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792903643;
	bh=Hq8kSJLbnL/rws3xczNEUy1qD3UM0OZc1XXBgt62AXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aVbN5Xyhc36ITlwF0SQc+vEw6nbFRCVw+CTSU0bo5MZqIRZpz/LMWYGXhILksff2N
	 3CdoJfZRHWUOYHqlyUbnzAAwscHE06IlaeH26hMGlGJIYAD39zskzGtxEw+jbRpwzM
	 SuvkulMFt/qiCaJlwW7wAiH5GcCKWSX2++SH0IbsgxWaPMRuywyCnIzuHTCGu/bUd2
	 oM+bWGM3+NUa8K9DwnMg+kkCEjt9KwpBwtAmJvCxQUGJh+TWflQzgI2A0hXFB8Lezv
	 3B0M9p+Kz/+fW4s8gNE3cIGc0CmSCIh2TGXTcB5f/E147WY1hLuDHBDfbE29KHJibu
	 k+lOBJXTp9pSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90BB64066C;
	Sun, 25 Oct 2026 04:47:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 374653D9
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 02:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D48C80E2B
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 02:00:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g3J3bsci4eg8 for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 02:00:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6490F80DB3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::92d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792893625;
 b=lfuwOKIWZZo3m79wqrhCmgSaMgBE7+gHaZ6HZOkoJbA+Lptrl04AZE4kHEZnezSh7gpk
 7koXNubJdda2IO7mw359iMMvT3BhmLq5BTyRVXw9V154G80LlwW6omoNyn2O/5IJHfbRe
 c059XoRwdT897mSwQRY2qrdlGJPvvKP3+A7z6fDqNB4L1imGXqBsYM5418znGWTwynUaS
 EJvCzQvHLipox84vKLagwIUbTkY3QDtoXZVD9gFrDDYU+xyOVhLhiCKZtrDRoNONGml7q
 wRRmDOsz8OTpxnZxqRxXl5W1Mvr5gfn+VArF3K9b0Yd1ufc4kaD6a/pTCT81xKqHaJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792893625;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Hq8kSJLbnL/rws3xczNEUy1qD3UM0OZc1XXBgt62AXI=;
 b=q39sCoV28Wxrf/0UylygyTLWaMTeMlOlzvEFn2rpX0A9JDTNfErjwDrfPQx6Ck8aWuh4
 tFvrsjw1+PYZ/jlN36CNFSTRnqVo+eGAG89mYsrHoMfauvUwfybLAnE3PbVNy4xBvaNfK
 EwEOljb9ImwGhxWzmVdYZvZdhxEobtLGwH0TGQd2ekCTAHVdHCQgXByoZjxd8hEotDJYN
 P8uS1i+hdXANSGtB4te/cxxkFjiCFHte7PUPgpE3fVosyWkTMbIF/XobCheTL6xA9TIjK
 kz7HOBFkyvTreH3jY2tdsWacqQOgiSM7HLRsFop7Orq1XbVFbIZtxQTt2wfP16M9mQQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=hJucMWLi; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::92d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::92d; helo=mail-ua1-x92d.google.com;
 envelope-from=mateuslima.ti@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=hJucMWLi
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6490F80DB3
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 02:00:25 +0000 (UTC)
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-9902a746546so1491754241.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 19:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792893624; x=1793498424;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hq8kSJLbnL/rws3xczNEUy1qD3UM0OZc1XXBgt62AXI=;
 b=hJucMWLikm9yQqoK9rAbSo1B+0jPTLtXNo7oiiBSsZU8gfQzJOUpAF9mCt5lvbwVQv
 MZ8WLtNc0nbHBDMwAXUMp0dys9d5bAuG6MlIKxXmKuje8rVP39lhyz8yrhCVlztotSzm
 8wQMa23oB2yZxDfvzAKj+G7hzGGJ4fNOO9HG3pQ3mbu2yGwl8wdgj1l0IM+Eq+5KbIy6
 Ur9RJAtnmQzXezMp722marRmzw1jWoQmQZnR2NXU1qXE8EGhZfTDUFwmFHUivJa+Nylr
 ZLURwR6OGNi2i1NYb2SSnGEm/dYZ0dSAmG6MgIp5ByjJCKUP5IMzt9E7l+U1ulpbXszw
 oetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792893624; x=1793498424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hq8kSJLbnL/rws3xczNEUy1qD3UM0OZc1XXBgt62AXI=;
 b=tHZ0Qf0WmXakboum+KuqgBarkQ55o8Pwf4SUtP1t8g6xKex2gxcOn4ph45/pAr55wU
 8OOChBj5zVfABqYtqkal5yFfzuGqV13uiQ+liQ7QtG8rFxBG7zHiJUHXsjm3+Ql6wMY8
 xQdoKr2Hidic/g8LcQKgWPOvd1e9/lc2Bg5jHVSqQF1/X2r2l7qGLOWeIP+ip1wzxNag
 rZoN9ubSMYyzChzFqbMdwEYRqH25dZljKVc5stR9wrqpW1KqfE8ONjs0iwetj3XGKb0r
 UL6DScKbJ0d1OQ9JTeRgZJ+YOBHL0WQEOknXXbyGmqZHQdoZlzrAhO7l5WAZ9+b9j9tK
 SB9Q==
X-Gm-Message-State: AFq9FYIUCbdIvo5NX/VxKt/bFvaln45jG7r12K/AaWZCNH/Bl5wW4gbE
 2olaA85sdozJ0laYYAhb1+5MZ5BfwPGDcmr/qdqnmud9qyaKkxF+X8MSG4x596Vw
X-Gm-Gg: AYBFou0bwDGdA6diuDrBX5Dn/D4lbxsT9VzNX2DuUeR+yFfcFtVVgmpqBGHgMI9k3yH
 Kue/2v81yloZHH2oqfXOmNJgSRWedZ3/AiE6pf5Q86o7gdag9M4o5MT75aVfYSECX0ld8U/Hcat
 Cig+lXDoj514qBv23QFwj0KMZo+jeOaUY79BL7K4uoquNCfwpZp/bfT6w/BRZ723Lh5T3qSZqpI
 Lhe+kRaMkhxFJyQB/bv8kgAvNVNmxDMxawdRQxibj5qEjgNrPUvo2xgJfDMte7YQIIvpQMhihx3
 JhQRePzC+xmzEDb9wKCNMHX22hkhhTEq4U7dwN+JN8lffcIAxqpsAxvurb59yi7feGoCXBJkRH5
 E2wNamKMWvvGspLMj4DAbb2ZnjwhQnDmVbfHSohMpt6IZMWVoXtczVOh+n5WCldgL00Wbs4ZUEw
 FHcRVmJi9Dm3sj2cJAc4L6KGV0Js73ktajt1uR0zNd172XHotnadom5TTuDvk4Ei17XX8NPD/SV
 XeZXf7yiaA50H2n04qQi+vHTJswpUqIsMy1/Ak5ANcbQR2vdHTBYmW9QZmj0UkVUa7bVYLhCqR3
 LuxGS6FHgS+wgNwnuQ35zGa10G4kRUjgNpjDv0yREV8PJ+T5
X-Received: by 2002:a05:6102:290c:b0:7a5:673f:9a37 with SMTP id
 ada2fe7eead31-7ce5d3e4c67mr621110137.15.1792893623802; 
 Sat, 24 Oct 2026 19:00:23 -0700 (PDT)
Received: from localhost.localdomain ([2804:1eb0:a0:15ff:76c:632f:8ae8:6a5c])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7ce5e2baf56sm3485070137.11.2026.10.24.19.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 19:00:23 -0700 (PDT)
From: Mateus Lima Alves <mateuslima.ti@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Alison Wang <alison.wang@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 2/6] armv7: ls102xa: Terminate CCI-400 barriers before
 cpu_init_cp15
Date: Sat, 24 Oct 2026 23:00:08 -0300
Message-ID: <8e9ad79a4fd29bf994af45752bd1a328191e9e22.1792893601.git.mateuslima.ti@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1d0d70c48d2486b06c57edeb56d68341bb02145f.1792893601.git.mateuslima.ti@gmail.com>
References: <1d0d70c48d2486b06c57edeb56d68341bb02145f.1792893601.git.mateuslima.ti@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 25 Oct 2026 04:47:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On LS1021A rev 1.0 the DDR controller does not respond to the barrier
transactions that the CCI-400 forwards before the DDR is initialized.
The first DSB in cpu_init_cp15 then never completes and the SPL hangs
before printing anything. The A-008850 workaround terminates the
barriers in arch_soc_init(), which runs after that DSB.

Terminate the barrier transactions in the CCI-400 Control Override
register right after VBAR is set, as done in the Layerscape SDK by
commit da25dce4aac5 ("arm: ls102xa: Add workaround for Barrier
Transaction issue") in LS1021A-SDK-V1.3. erratum_a008850_post() enables
them again once the DDR is up.

Tested on an LS1021A-IoT board with rev 1.0 silicon (SVR 0x87081110):
without this change the SPL is silent from power-on; with it the board
boots Linux from cold and warm reset, and 0x01180000 reads 0 after DDR
init.

Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Alison Wang <alison.wang@nxp.com>
---
 arch/arm/cpu/armv7/start.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
index 833486817f8..b7c883cab91 100644
--- a/arch/arm/cpu/armv7/start.S
+++ b/arch/arm/cpu/armv7/start.S
@@ -114,6 +114,12 @@ switch_to_hypervisor_ret:
 #endif
 #endif
 
+#ifdef CONFIG_ARCH_LS1021A
+	ldr r1, =0x01180000
+	mov r2, #0x00000008
+	str r2, [r1]
+#endif
+
 	/* the mask ROM code should have PLL and others stable */
 #if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT)
 #ifdef CONFIG_CPU_V7A
-- 
2.43.0

