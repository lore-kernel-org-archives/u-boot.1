Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7EE606A321
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HpkIyiba;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ejW0Ez3G
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3C7D60710;
	Wed, 28 Oct 2026 22:29:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WrTYhQX1Lnj2; Wed, 28 Oct 2026 22:29:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EEBDA606E7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793226592;
	b=KwSACCrFiBYLWbfmuB0D7MpAfcMNJf4kiuRkr3UmOVvXjYWI2VU8On8GKfVpRV8auu/X
	 QgvTZk24SuegQvY1AmdBNrFmyTtvPODPjpBbL/kiYy+yb23bkuuMTD91nZVHl+RBROCUY
	 87QrT1BGHd4svEehSnDNn0Qv7sD0PFsfbdAXGCUd1jqhpOpQybsqHg6e4kSAnOpD28Dn2
	 jtuhhxQOmzXCc1cLYEbgIpVShrrqpZDTjLibh9+cYTSFpjhpJfPCkENbfNXYpYFwOO3PI
	 kF4/5QUYL244BEjFH9b9PpyHgRWszi0ZDcTq1IEiEUwB0gkDqWW6k+iOmXhfYLfgAHQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793226592;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ujEeQOtngMRZBJkdIrcnasKkHIZQeAYl4GsUPdk3Ug8=;
	b=h5ZVIs+64kxfWRUufMtWDGOkKKYIMPasMl81KkmMZlsg7xxYXLiL7F+I1koI5YMLQAB6
	 AkogECVW6AOCGHJuCI7S8LZ7KryivHO3JaEkca2oj+z+bauU5nAX3BuPbAwI+QadOceIj
	 MN/DRya5UWfcu6FS2CJnfuIEkc+jD+XYfZ86hMoJpc2FbkvMaawmHqeb0cOMOkxIKML0z
	 DSegCmjXie87DJ0Krkaxh+9kGp57TVslNqRGVPwxo5P4MiK4NgHsh00z4NeT2i2NpJEd8
	 /meY+47KtOAiCalPcqUNTIWMteLWuikU+sKOpGbuKUZxion/ac7zabsLpKfifOiBnxw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793226592;
	bh=ujEeQOtngMRZBJkdIrcnasKkHIZQeAYl4GsUPdk3Ug8=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HpkIyibawfr/0Pc6tdwTXYZY5o+3+/eE1dX7XW5d4F0Gvi8FRpBLgDoYdotdoJtGi
	 1nu2ChMo+8QECT3rpV7VppIUhJhaU+NoLhrugqPwI2KR3RZRhpSc+e603zGcvTEoWz
	 o9yWJ4dJY+kmHHJyJSTSEjoksV3Gs/yYJ1ZerXrB/Ap6llLeWidar1qgStBHoxlaML
	 ona5wrYn7tWWJAfWUmPRf26QgVkgZ3EXjB74ttBdNE7DCEux2aXfi5zTB+6qpgsBUE
	 fNFbcLP9iqYVXXL9BmbhsnTE/b/wnYynjZNwlEwBUGN83gEWowSZV5k6FZUXOyuWEV
	 vYCu0R02n7yFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EEBDA606E7;
	Wed, 28 Oct 2026 22:29:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 98A182A8
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 22:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E85F8101C
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 22:29:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eIi36RsxiRo0 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 22:29:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C6D0681140
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793226590;
 b=kJXZlIRLM2BXLjIl/MTPvih25uzJ9j6lSJMMdKNpi0mFyUqIc+yRbZrKivG5FvBC8/Sh
 eOsxvvV68RxxGRgBcpZa952Rn5EYYRR7fRENwGLqLH2Wxkze8Mdge7IywgUxIVK7aPm30
 RuYa1VLW9vDHduTWKBi0/rtzXHWdhsetolA9PadSoCKr3y9bBNcsn9kKEaDZ8rBOWuIwy
 6CT15Cw2MZnJ7+ixVVqL9WTofY9yxA3hXSR+lCTl5ZDxkS1+Y3WJKmODnpKa9tj2NjwJ4
 GIr36dVwQEso8AWVlmJENOh/UXLm2Q5Kjy17B/UQ927W8L6RhfQRCnhXxZhHnS/qdPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793226590;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=ujEeQOtngMRZBJkdIrcnasKkHIZQeAYl4GsUPdk3Ug8=;
 b=Z121eCJHMVWpoEjs6o7zfaibmvyUtGih5waZyoazY9yGVZk2kAzFeAlb2bTM7NUzgj9j
 Ju27b9eHGL625EB/070OFHbIbC2bjiIqj6G0mCa1sdwk1fQJAOvfcZr3Rso71QaHn4aQx
 KHjtKieQkd/s2InDZ/2WnZwwaUES3LUBYW/ST5go8Di71AcbE4f+1tOVXg7QQSBGMIGsV
 GJKxC0MOkgdSFAHF2P7AKy3ZDZrsc+xIrFI/Zf90+AG1OAcw5irOqMMzM/vCruE6m3kjk
 YIzYjrmYZaMlMlbEIEcZM9wZ1LAHI71IStZ2BNU1xpv+eGAAGBCsm3Qtrp+gKc4VFZw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ejW0Ez3G; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ejW0Ez3G
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C6D0681140
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 22:29:49 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6deb848ddd7so1185510eaf.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 15:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793226588; x=1793831388;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ujEeQOtngMRZBJkdIrcnasKkHIZQeAYl4GsUPdk3Ug8=;
 b=ejW0Ez3GTmLR0KQOOKIVct+0etYhYCWCL6iGu+19W4STyjlQNbzv077hSsUHCUdvVx
 t2m8hcitwBVAcKIN0LKksQrXaQoHbK7V+zPEx96UgbAggaSsHbNIveG1CMjnMgDBxxOx
 tsGvFB/psGh/TJ2mder6xljGc8lL/8xyxRNQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793226588; x=1793831388;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ujEeQOtngMRZBJkdIrcnasKkHIZQeAYl4GsUPdk3Ug8=;
 b=Pa0Y5J/mFkQTu3ZZilAVfv0+MxGKzVjTCXkEOdm2WLudyzuOafSBsvIwIPR6XavhVQ
 9XeLsRMyPYBaD6OnFIV1wPr10WYmXjbr8Ulvts5BDbsWnB4mtTq1nSVhj8gyGOBb14GX
 Fs27dbUXX3vID+9b6RoZ/OG4CtrZ5FDusHgSXicbb6TImExKEbROaQ1nkiGeTTmT/GMM
 YnukVpojFkdAekIQlKseVcAZ9EGyCr1mT3TlEpCRHMyybCvxEbHf9Xbb4XN7DBiaAVhb
 pVFiK7ZuatXxNK0N5fBV7RFDLA0hqqLajhgEV41SOrjF7zFDgO3kwe8ghbAYeVOTLIhq
 +YDg==
X-Gm-Message-State: AFq9FYJ0L9XP/ventVzg0PqBtvwOPAwUXzYDpFpf+yCIE7BSoNMRt96a
 0Zy5LsZOL9Wylx7uewo8+JPu9gZN9UXW2vYFph5H4tCJII3NrzdI6hRUeiTec/qGTLy3MO5PbN4
 /aw1UxW6pV2gi
X-Gm-Gg: AYBFou3gqqX4P5gnOprM5L5SLK2yLJzTm1jec4nmkJjSPsbBp4xaGCJLGX6XiQqQgtj
 eJW767H3icBOaFQSMxQNsCQv8h1Pf2kQ/5rsKuGdZuGvKgPuf4ToOFArCNzxwgRd5dzqArIKCnX
 kXL1KjZvvIL9G+z3rB5ZUvuNrzVvjWqFmOA5M4CASuBpGjcmIG3n8U2LmGITfab7KrjfIqRAwha
 atNQXXrgAWnA14bahwv55lB/eZiO/KhZ1Pkj1H4d9cVy5Wu6bARfbzCheemQhbKegI+z7xq7iJl
 Rsi9yKHR8/bbNQZ1Ia5ddtXr7S9+JtzdwbxMwKOmuJa1gT1goWohtdaCW6hn3QbS8DyMFcKMCKe
 gjljm+L6Ay46+zCTVMMFZilqgyZh596+Zw/0DLV777c+TQ8y30MYo1XhIFgb83lzPYnMqxefbyW
 fte82OS2a/SejynBSI0CcqPLyJFjaWJVzFfkWYvud4H2bqBRPV0//i1MuQeJerZcvuxoufcwSpI
 7uyHDD8cc7I6o59zyxZdPuW9GkcBYNCXjiAHCIp24XLSGQfKhUt66PcAnIRTNSrUbIDNi0SVcTm
 oY/wZD5khuIEv6pbVaJzG0/YuGhl7Huc3Pl3rFgitwQp+lV2T8FZgV034e4hX8wKeWd6dU854xs
 lXhgjyzLvdxpDMS1YQiuFPAKy1c5Y3GAStBf4QuHlOvPn0/9uAlaBWFD5hMlQWaP7MJlFcYCP+b
 xJnMwbxOKWQNENoxBBb9/kVzb4xIzvH6fivegog6Sj+52OFuBHdHnMuE3l
X-Received: by 2002:a05:6820:c450:10b0:702:f7c2:1937 with SMTP id
 006d021491bc7-713f06c94d6mr1602465eaf.83.1793226588180; 
 Wed, 28 Oct 2026 15:29:48 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1fd30da7sm3447402a34.15.2026.10.28.15.29.47
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 15:29:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [PATCH] Azure CI: Update to using macOS-26
Date: Wed, 28 Oct 2026 16:27:45 -0600
Message-ID: <20261028222745.2775066-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Azure has deprecated the macOS-14 images since July 6th, 2026. Move to
using the latest current macOS image which is 26.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .azure-pipelines.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 556828f42fe0..fcf7aafade6e 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -1,6 +1,6 @@
 variables:
   ubuntu_vm: ubuntu-24.04
-  macos_vm: macOS-14
+  macos_vm: macOS-26
   ci_runner_image: trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026
   # Ensure we do a shallow clone
   Agent.Source.Git.ShallowFetchDepth: 1
-- 
2.43.0

