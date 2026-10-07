Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACB7CA6002
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 22:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A75BD60B4C;
	Wed,  7 Oct 2026 22:16:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sIQRIwVd5ag1; Wed,  7 Oct 2026 22:16:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A9C3860B5D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791411392;
	b=TxJ38C3xtsJn5hPDmXFrYPZ3sN0SPqKsXr7+5jFYLnVBDa6ppF1psRIO/4Vg3yCoSK72
	 x4MnLgDQjhKvSFGVCdBIV3d01IKT8tjRVzI2ghRPursCrWQwpwDYZ/qbAAgNhCAZv+RRH
	 Uybfj907NNqT5LWlwAG9NVdKfHRnhzW/a5JSgskpyUfFn6DGxUg8nP2srPBYY4sgWWbe6
	 Pp3OSFNxPxROVSOdG2j7RbHpE9YxXUNTkHJ0LfV6hiF6R8gGF9JhWWmrcFvFxTy8KNV9V
	 cOUCldmIzfdt1lVWvAUqMxKh7aSShGNYDGgKnHmhn9oFJmoZ26HSGKKfYZTdjmPDKAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791411392;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=89oKePTA0pF0dp14GJyY0jH7TgqJVs6OOwf/MFTXAsg=;
	b=s9a5Odo47UYvBD3ccS1DXMefWCsEY72OiIeTASiMj7lYJkLjD/9w442RHxSkSVC8ntXp
	 HDNV81FYhd4Luoh7TCz16MxVIaylsF/NWdJri/ZO6Jz9Nu/NIaNEp+Xn6rUsD1aMFm2/Z
	 JlJB4X5KJzGJPb/I8DSi3sNIBX8kx84O/VwVamt21LF+ST/IG2tLA53sE3y5O614GKdj7
	 Y31CYiIc5ZFnqWIZFM83dsbRzZWYWNf0888vFTimPfGGEfIQKAO3uHD2inwTyLSSJE2Ht
	 oH1tIJXLatjnZijKHuWUAL+7GrnmMhiIII73yKkoNiut0tWv/5uaWGrZ2Nay2CyKz1A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NCtQ2BxU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791411391;
	bh=89oKePTA0pF0dp14GJyY0jH7TgqJVs6OOwf/MFTXAsg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IiOA+6hOo7UvJ8EpfgoGCl7Hey0mQlezDjy/z/DSZutPMzILWUmqDssEGVDKYaF2a
	 W8yEfGuiMvqNzQciSmvBBNGV6KiEm5y/XeaH1+uOP78PVMxNqz0QvKZbd8Xu6itSC4
	 rmxF3DJx1RTdEPZmRE0NswaZ2j/L/honwzoxetcJagvQmIXOEXM1sWk8SI4l/p2JSk
	 XcSgNCRgw1763iNN1OYvRf9slbVrw/vFCri5XipnmON9ie4ckd5Qu6tsYHnB1C8b4p
	 rAAr16Qp5H0ctYhAdMkLssIbgx3mZXe/RbLN1Gq2HPzD31Ehm5x5vPboMCk3tSB/NF
	 C96bgTmrl9jzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9C3860B5D;
	Wed,  7 Oct 2026 22:16:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CDB1A32F
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 20:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B405D60817
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 20:42:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G0rNH-GAVACM for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 20:42:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C41FA6064B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791405767;
 b=ILIKei5lLyNoKYaWnlqSEaqtQc33dDpTeIYfgNnjOshckTGORswu2cpL416oQ+KnvE4I
 6Za0uHmFj99Z8H2r4gWsjhBIWl0TuNQjLXVgjCBw1F1v/xUyp8nd/mXjzsNF8W9X7vNwH
 ArV7/0yKaJRrZDyWQjMyrV2dHPvPvqG9VrHkjpHzpCPRKDBvQr5u/vtinKHAzW+pjOXOm
 VI4vdSJOf1QdDAagPu5ayvCPE3RduVoKFsBXKOkOOww7baNj8s1ON+2680iXO6odtZW7p
 Yn7j3GWze6TgIH4OGq58SjOSV7/bf+lY6GmutrdJDEHx03C6c7qk7lI122knjgi0l1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791405767;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=89oKePTA0pF0dp14GJyY0jH7TgqJVs6OOwf/MFTXAsg=;
 b=F0VxeLe5d+ZpMfyZxWVbqTixb5ihsrMryh19qqA0DlP7wYa+2nXw2jd6QdpcLan15ORi
 yz2H/l0lo/iw70mG1hOe+pZAln5TYxo3o4GpWejIMgobHC3Fau/Qs9AXYuzxTMMvk29W2
 UF4mFKRXQ+FXTdrc4aT63sg3pnNldhLpwktf+F4xgrr8V+qJ2vOBLLQwBojsIPF9uml5a
 YIZopkExFhB7p1hWh3qZrrlhipub/Y7VrDKirpxt8LQTZzrHNyZVVOJvGjJtwtvrc85w7
 GHx56HzxhHd5MKLCiVXy8uT5zD9KMHch3vBUIxz0n/v8WfIbUuzm3Zb/sRZt46hHPJQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NCtQ2BxU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=NCtQ2BxU
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com
 [IPv6:2607:f8b0:4864:20::132c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C41FA6064B
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 20:42:46 +0000 (UTC)
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-34bb8b31647so7158758eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791405765; x=1792010565;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=89oKePTA0pF0dp14GJyY0jH7TgqJVs6OOwf/MFTXAsg=;
 b=NCtQ2BxU2AtrYQUMOrLsP37H6elLD/uCoNixkAsxu3ha9mJzAR7jU1eEStnbqXsntt
 01ZLxN8KFhrSsWK0LgkEzu+xaaLfwGoMWbCekprwsYe2To9pH4ieEH6Z2ROqA5z689+A
 a4Ecq15bJ3EApGRRvUYeauM8NOlGhXFV8JZlM1snVVnZ7wudTkFcTV9WQ1wQ60BG5drO
 crvogHVus4B9g5V44vAb6lnS4CBGRJh/5TtZ5cbksvnxxooAJHInBJfOkomhfUnkVM8O
 K8jn6OlAG/agt6EWAj1m3Cdtuf6dktBQmPoDvx7XEue303HlHmEuEZyZcC3cL+QripBg
 mr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791405765; x=1792010565;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=89oKePTA0pF0dp14GJyY0jH7TgqJVs6OOwf/MFTXAsg=;
 b=W8QrmFqovIpeU2MGSPCvtomTn3yJwnCO67QEhL+am0tKHmc/ZwQ3PERRdIauKsb4yc
 PW+a7TTywjZhCO4HvqnaDCw0ppoJbGWJxzFiDh9/3jcdCw4A3cKp7nt1+tQ3h3IYLvgZ
 e8uebxcGLXEOB9a0NbNpgGeq8MagOeVdS1R6IrotBnyAu//Bz/9Nf2B99km9vPozUqsQ
 OSBaIJ72z2/F89WwYnGfs738ZfmQpPoA+hASf+XKPBEAR3xkrJvOIOjpuybHA/+S/hik
 qQTRc3WU5tg7VCf/CGndKxewud9zIPzOHPqame5biMUHAkMvK8NQuDna4UDaurGcy3Uo
 90Gw==
X-Forwarded-Encrypted: i=1;
 AKwUvByd9Xx+JVMSMA7s7LTtHiqaHLSNrCx/r9m2bKDJ9NYx486f98uUAaoCi48ux5xsoSs68r98Kk4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKoqsqxUsM6Rw4E5XB/8Y146lWxQtGybwi7p2mZD7kSgWToffcI
 Z1wcVVDDdIk+BUuIdbB0ENYLLiimxpx4OeI5LCymNmMJJhKOIQZR8ySnJ8nC2w==
X-Gm-Gg: AYBFou33Aki0k+UMg2EZcVLxn6F0w6vE08W1WByTjuojBNVaNc9P3/d5vfD96EuGN7a
 msKtQGGcy4BmU+lV1Px4z3AtuMj+SMUv1VTG9ZBMVLvoUTYz5oSJ9N7v+5AAZ+hv/jJxt4ekxOP
 1npS9WEZ6iuJqWST2IbpMCyeLteE44qLJqxpyXPf0fHFqWr6awInCoxV0BjzRjho3FFspeDdCSJ
 CS1OTpIqRX/MVgjuY/PLO9DCu/Joe/lk9jfXMciwF1hdVz8aDr/5qkHChUY0EpXK/q/Slq19aVQ
 AXhx5Np9UZhuzB9bKZii/klL9k04r2oxwIde/b7RgN06xOrQbVLwHOMEbINpnkgpCOLyUDCYa8O
 QPa2+wC0FgnvVe9kpVaCDdtFygsy9A1vUFR8G/lVGQSs3HSSy7ZmlwX+747wiAWO0RZGtEadbJt
 Lp+BeDhaPmjp2GY1WVJCIaQRWIBs1TmYKDA2mf+7V4eGm4/rxvL4hTtKX7RZ1LjDVYLW7LegAXh
 kw40JKZ8DjM5iHUw3aOI0/AG7HsogVitSaY6acDxIRNv0IROhWEkze7eiJXMaOOIr1FJIJNbOjM
 hBUd3NEX
X-Received: by 2002:a05:7300:b088:b0:34c:b75a:ac1e with SMTP id
 5a478bee46e88-3515df70a46mr4004583eec.33.1791405764732; 
 Wed, 07 Oct 2026 13:42:44 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (33.223.194.35.bc.googleusercontent.com. [35.194.223.33])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515aeb5fffsm8516345eec.6.2026.10.07.13.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 13:42:44 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com
Cc: tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com, sjg@chromium.org,
 jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com,
 marscheng@google.com, u-boot@lists.u-boot-project.org,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] Azure: Switch u-boot-test-hooks to git.u-boot-project.org
Date: Wed,  7 Oct 2026 20:42:34 +0000
Message-ID: <20261007204234.1081107-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
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

Azure pipelines still clones u-boot-test-hooks from the github mirror,
which is missing the recent qemu arm64 9P device setup and causes the
9P test to fail to find a 9P device. Switch it to
git.u-boot-project.org like gitlab CI.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 .azure-pipelines.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 5bda11a0309..d88dc35dea1 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -279,7 +279,7 @@ stages:
           # the below corresponds to .gitlab-ci.yml "before_script"
           cd \${WORK_DIR}
           git config --global --add safe.directory \${WORK_DIR}
-          git clone --depth=1 https://github.com/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
+          git clone --depth=1 https://git.u-boot-project.org/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
           # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
           # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
           ln -s conf.qemu_arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
-- 
2.56.0.360.g66cac248cb-goog

