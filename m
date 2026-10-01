Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C3ECA5FCB
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 15:24:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A320660B5E;
	Thu,  1 Oct 2026 15:24:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1_PHI8mfwCTw; Thu,  1 Oct 2026 15:24:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DA5DD60A41
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790868277;
	b=N/aUrYRGf2pZ3Sc2sM/7eW+I5XEkUnvkJnYfWnUQg53eeLjNzrrURTTN1FkOaw3wHsvb
	 dsAeyqMI2W6p28fbO2NWgJTTWzFFbmyzxpB20cxD9X+B+NtZnLIRK+JmrQUk9EehY9ur3
	 CiP/VzOui+tYzObvByC8dPpOMKt2wTib7YD+MI4HO0dLKbrVcb3O24R1Uy33cwEOlEmA4
	 qBH7RqSHY+dI62htx804J/8zC10ZKssbcaqGA2sPayCo6+fHFXgW3+mJUkdJ5jyP/bW4h
	 DPh9lMrlUKXJt8e7bD+NVTZ833WCSy88zNkJo2Xhsfczl5Lypaec4XV6pSaj5S+RGbA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790868277;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cDw4eOW6WRdzotgmD4e6pO0eMOA7MhTYYbENQx6V3Yw=;
	b=i+cMM9FFCgSp99i0KSIVVRb8Rnojclr94Yl+kMRQd6NaIE13aUYqcgspmtl5l27uOrf2
	 Y104wnFTizEoWYRvzjkSP6erlW2zuIhQN6OPfvzFADY2SoQSu9r0q8aewAyghG5lokBlT
	 BFNapdPL/phqiZM68hDaVj7fzGx8jdLSAvgueH5+CaBaKwXOArXdkLTwmjuEIXiEQ37Mu
	 rD8DO/2HO0XL6wOWkr1xHfYGy3wUuxx/KBucSX1EqHwz82GGlfJM5zmnDF0sTHzcnXOA4
	 nUEEDYqN5PQLktTTTUPxhg7wMwfj9hrw7koEzwhjMW3+bzQQ2CkFB3PMdpQ1ryulcdA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=RWrEvrL3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790868277;
	bh=cDw4eOW6WRdzotgmD4e6pO0eMOA7MhTYYbENQx6V3Yw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=piRat2lB1rww1p8c+Fih4IHTsL9fEAqGIsCAGVflA7LDzI74CLGL0ZKkyRYIN9SJ4
	 KpRjEoYbSR5X0uZazyXd448vtmO/Ov5gJBenyVZvvi316aRX2o0Jb4cdJRtd0RGLiB
	 yjRP51NXpG86wbX3muf7MVYHDmj0bOFuq6kzOyXoGBz+9Q8rWGlQYGDTUusfrIejee
	 gIC2vOBGL6x2pIcCmEBmKPoyl8DUtgtckWi5WlWBbpnYXz3Qovi7ST+ut0kuJvn88y
	 Yw7IsOrmsQoPD4zGAL7RwdbbU41TiCJ96A8E1WNUV3azDEacvsDLgwnCKlDGEjMLeB
	 BYBaGYR49yALg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA5DD60A41;
	Thu,  1 Oct 2026 15:24:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C0BC83D8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:24:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A669760868
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:24:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vMIGCoCByE7K for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 15:24:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F37D860897
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790868275;
 b=JOtZZG9t7SO69ymyg1VNDHFIA06ScIZJJqKzHHZXL9+SRjQtjz83pNiryIzLFSfIRxkj
 FgU6VZJeeBBbxl2PFdlKrqiqLm5i9zCnxvNUHXsYtmZfsKemg81/zYFtPyRdHauzHl1mU
 fTxTFJwOlESoBebLuahs+1nkF2J6lR49Epoyzg8pi1my0Vo+0nAA5sFxno7K3S4Ut26h2
 64R8maTCKWPX40eCdg9z+U4HKszKqObjRucwQhOLQfikWSBiw4ytibhtvbGdq12qtbjL2
 zgS4ThQpz2h16mgEExkRZQSlNM0SalVXU/10FmcWKzrbln9LsOgXRo69x1HjepQf38w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790868275;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=cDw4eOW6WRdzotgmD4e6pO0eMOA7MhTYYbENQx6V3Yw=;
 b=Soga5THMWYWGSAnZvO9lZ4NdIrpboHna1ZOMxE2zwuyT03LbmUz7trB2SohA25w8Ub0k
 71ypRTTIGr/472bILyF8o89qJiH8u2suqHjpLBg9fjHBfelj2/SauH5DGTuN5EfQh0W1h
 FTln1km1hTkMOaHCpWF089ZB3Un7RWn1OhOY4gjDJHU+WVl3iGEu9vq1l4tam8WqOqqRQ
 QdQ4W0ZMJAdm25ONRE7WReLWOPvnzTpUSK1oLvTTRBlpU+7Ltg8XCyjtEGcx42Tb7Htyf
 eA5uvCGAXGRB6zGRb5O3bsJFU0ASYG0o3QjGwXvq+4h6VToTfhXnEmqRHlMb9gSz8BQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RWrEvrL3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::f;
 helo=mail-oo2-x0f.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RWrEvrL3
Received: from mail-oo2-x0f.google.com (mail-oo2-x0f.google.com
 [IPv6:2607:f8b0:4864:31::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F37D860897
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:24:34 +0000 (UTC)
Received: by mail-oo2-x0f.google.com with SMTP id
 46e09a7af769-81b15bca7dfso3888820a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790868273; x=1791473073;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cDw4eOW6WRdzotgmD4e6pO0eMOA7MhTYYbENQx6V3Yw=;
 b=RWrEvrL3377EV9757sLbJUTDvV9WMM3PrhO2FN72GEKgX2lYDI0xJ4CHI2LBLlR+8y
 8fMQ0i//rPAQMgJCtfErUa5ojjNeGmjjfnklbQpnb2gZnNnpuemTqAoIKCKNTrxOdPyT
 TaLuLMSp5ZAS3C1ZYzW7QJjjBx1C31QPSAF0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790868273; x=1791473073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cDw4eOW6WRdzotgmD4e6pO0eMOA7MhTYYbENQx6V3Yw=;
 b=KMmCDsVi4molUzH90MuRUQVi8KrVpDCmRA+lZ+KeEsz6uc189cpa0ESJJY5LPGDF3s
 QF0fRjZdgY6742hGnSkI4q0TTV4a+IMCBIweQTymmDWg88sizfDcsiqruPzArGkxqBB2
 siTJs9yvzIfTIk2+9wcj8zzwdqH+8AFIw6xQn0o9knfxnadq5XHz84MhnVppbnmfPohu
 oq87O6Lm9g4E4EnK8ttBJybZmW+emztrBmr/8JhgiCK+DKXhHa1QL8i35KhPP8G9k6/n
 CMZvX8p+xOXxPkbIgA8CEsHHeP6/Qln63nmw46b0hKAR9X5eWFompqb2jUI+KHzNC9g7
 VJhQ==
X-Gm-Message-State: AFuF++kqoM+Ul2AIoNp/A6UpqCdwApqwow39gpCR1Vxl2AGa2nhl41rQ
 Bz2XFvARiFAeqmNtkVb/KQjhKHU3SwYmHrLWem9kmlZ8fDnlFtqfpbnVgTmx/GOJI8Cx7SicGEd
 DLxz7tRvVoTIZ
X-Gm-Gg: AYBFou3iWtqsOc5DnYnnTn3wrpPlCFwPbN1K7oBRfmGHyT+U6JLHGd+N5qW2jPzgvD9
 qzJ95GWC9RkfUx9owSOB2O2Az83LbM6+/ayQAZThzN4xUqAOTXJnooPhN6wahaAnjgKhNyDE0W/
 jCaAar8+Iz/X9u3BbKn1vQ8h5gctRbAOTqI1L53y/wMlzvjihOVhPtc9zg1lc/bE33zlojYwkKC
 sbEgdEbv09R5HuQRUxR0tz4DhkiW/vJiModEua2VOH4Jmlv8pOG2Ke7zqGLrRQuLAR+R7IcgPun
 wFna/FPk+5MP7ig1xMqUhzO7aL0MqGUz010DCxljU1x9ZclLBDmKXl7J7PxehncvHXjZzMsIjiF
 gwmQtQw2dCZRKd+AHEQBmSOQ35WUD1+3mmh/hMpOihkU1PE0AR2Y14WBu9w9HJ5D93OGuV/vN1s
 7n5pvifa6vdJL7hcejFSJtTNSbmWZhtJoDORhRA4I36klrOvQwz9SHzSIwyKEqHSmFlWo8tl7Z7
 fl31T/PtLIBhWHrKZRdvgXJlu4NINU7B3iqZbvnaxNRfpWcUs3Sm9Q4lDaSyK7Wu3MuR7t8tqD6
 6kMDvN39iIlOfv/8leO5Z/tegXWsjy2pokaDcC5v6n4=
X-Received: by 2002:a05:6830:2b10:b0:816:9a55:476e with SMTP id
 46e09a7af769-8204beff978mr5682812a34.31.1790868273293; 
 Thu, 01 Oct 2026 08:24:33 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8227a66650bsm36700a34.22.2026.10.01.08.24.32
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 08:24:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH v2] Gitlab CI: Temporarily limit thread count on world builds
Date: Thu,  1 Oct 2026 09:24:31 -0600
Message-ID: <20261001152431.754329-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001012043.570450-1-trini@konsulko.com>
References: <20261001012043.570450-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

At present, our "fast" runners provided by OSU OSL have a CPU cgroups
limit of 28, which means that we don't run our jobs as quickly as we
might expect given the number of threads that our older version of nproc
sees here. On the OSU OSL side of things, they are aware and working on
a set of overall improvements to everyone using the shared
infrastructure. For the moment, we want to limit what buildman fires off
in this case to not essentially fork-bomb ourselves. Figure out our
cgroups limit and pass -T if needed, or nothing if no limit.

Suggested-by: Lance Albertson at OSU OSL
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Lance provided a better idea here that will also enable seamless
  testing of their backend changes, as they happen.
---
 .gitlab-ci.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e08068f1cbf5..0338f20b8a2e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -157,8 +157,11 @@ build all platforms in a single job:
         -r board/qualcomm/requirements.txt
         setuptools
     - ret=0;
+      if read q p < /sys/fs/cgroup/cpu.max 2>/dev/null && [ "$q" != max ]; then
+        T="-T $(( (q + p - 1) / p ))";
+      fi;
       git config --global --add safe.directory "${CI_PROJECT_DIR}";
-      ./tools/buildman/buildman -o /tmp -PEWM -x xtensa || ret=$?;
+      ./tools/buildman/buildman ${T} -o /tmp -PEWM -x xtensa || ret=$?;
       if [[ $ret -ne 0 ]]; then
         ./tools/buildman/buildman -o /tmp -seP;
         exit $ret;
-- 
2.43.0

