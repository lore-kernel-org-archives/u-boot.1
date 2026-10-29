Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16960606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WIziOhDS;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=fvajxaxo
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF643606C2;
	Thu, 29 Oct 2026 09:43:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KJOrLKVsVt-q; Thu, 29 Oct 2026 09:43:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EF43360686
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793267001;
	b=hRLWx9jjISpD8vd3jUl5xQlNeU+dQdIt33Ms9fgfobgNmd7XDWY/GlgRH3S9eZSdXy93
	 1pxN2P5/8RBcwoS97ZnlvwFRNezIPTR78SB4qKM8Q3gZe72Foh6G+mmH/uijvqPPLZhrD
	 fOXKOcfdg4VQzZycVa6McrHvCkgfGr39YsCo7OG9fJU+UJMwE5OhNj7zC8hIKu1eYtddS
	 C4Q3ftGXc35y3Lk59vWWZ0Td82rhZflPwUZMY68KP02xFwwRqU7z8gyY8WhptMIowmlbE
	 tXTo18mKHXJwNDCqNILEWjYu6XLDOSoUIIEFWZQ5w9/ecwZAVoUyJ5gmGuTuSX/WTlw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793267001;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z9C6q1b3yB/D4jcpthLs8tCgTg0zR/ykf6iluViV64Q=;
	b=pYxiCqb0+x3AVRZ9zQXCEZ8XxXbvNT2nninkXYPDPutBhFQag9ld5ISnoFKjK4Ho4RTw
	 Z6sh4uYHdlJrQpPuoyUh0/4u1PRukI6RUYRzux7sqpgQvY7Kf4+/lTSetqWsU8wp0plpv
	 CTBi1KInnS0GPVIvyEV2LDnuGDhrBMV6IRFH7VAn5fViROWPFbQWhaCEOcUJBHuOylPgv
	 nKF72WEL904/A6HiTCG8i0hYZf2C9thkjaANs4OqA8a/PNdQfEn+xVQ8NqBAI+qBJQMr5
	 oDdQo8rSm/PDDL9JPx3S+zW/1xOtxx7gMgBPXUwfpfASx4zG/eHGLui/LV7zVJZldbQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=fvajxaxo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793267001;
	bh=z9C6q1b3yB/D4jcpthLs8tCgTg0zR/ykf6iluViV64Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WIziOhDSwBJB3U4BqrDds35r8AFuRJZG832fzxAtQYb0GKCBUXDhqJMbrotMMy4pS
	 oxsg5yq6s7IO+CgKDCDTa9Doj2bdCcZEUzVEbu5iiAac+LyngOJI+f6uTV4hhpcHmp
	 5BHC5rTrdQPDUM9F/dt2r37eVU47kNZSryDq6CNp1ahGnSye57rrYbdFTFKNC0RJQJ
	 zb6L2ZifM43sgLMDZglTVLckWja+3cu52H23kI88HHK/lcZaryh85xDohPXSniYUOM
	 MdzBqHY1h9rgIZhlmaa9D7kuGrXOOfqxJmSuiEBM3jwGA74AvZ67GRCqjs3EtKCnpB
	 nH1uiXfvSFBiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF43360686;
	Thu, 29 Oct 2026 09:43:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C2FAB356
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B511860686
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:43:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XMxOejBF14sR for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 09:43:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 804B56067E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=84.16.66.175
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793266997;
 b=k3ZJdp07jY1NioS3ihiNaub0wXG/5bzi/0Xb+ex8WkhKG7NsWD+qnBHe5a3LVoqV1wwA
 ZaPxrOhIn8+D3L9Gjdlxg3tWEQk3s7JS2alphDPvQnivpufUSBo9Gx5TUx7/v+DpRH+9u
 x9GB+VC6EhnXETbx7Met+DHLFwFOJtI8s/XYM3oYsfjkrG0HcNQBOlc/POXbUXJPuHI+L
 7+J3ytwX9QB93f2CgSF9uJquOrhfnSsgtWtshAIJBfdEHo490AQNfNBZMm0eQKRzCFjic
 JsjBwipObEZtl+eLq31Aap3oYmSiO4KocxrZ82yWCz3WCkFPorpjJV1ocpa92XGys0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793266997;
 h=Received-SPF:Received:DKIM-Signature:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Infomaniak-Routing;
 bh=z9C6q1b3yB/D4jcpthLs8tCgTg0zR/ykf6iluViV64Q=;
 b=TNVJ9IRXjpxA772vRseN4z3LVo+Ot4u7OOPSu6i2GlQ+0hDNsksxkYPPKlnPaEp43xTl
 nLMLsBd+rYlcPoCuVQ4eMWYaNOq1R2iIU+CuQnKvB/KYtBsZV/H90SnQHJMqS5TYVb7/T
 /sR/QEdPvxEbUeO9ZNuSM3AP0OcGR4dQOzglTpQteaPXW1rwKadqMFporFKUn/TNvV5xU
 sQE/yLHJpt4zAMhb7a91n2xEYLMnY2CHtHlz4XJslKu+Tpvz+MbX31aoTe2bKmsa82Mki
 JF5CpYZNdtmw4P3Jv4TZHN85JPq42DGjsjlcfXp/YxbNchaMuWg3QBgDui9gEblGNdQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=fvajxaxo; 
 arc=none smtp.remote-ip=84.16.66.175
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.175;
 helo=smtp-42af.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=fvajxaxo
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [84.16.66.175])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 804B56067E
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:43:16 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jFf331d3Nz1h9W;
 Thu, 29 Oct 2026 10:25:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793265918;
 bh=z9C6q1b3yB/D4jcpthLs8tCgTg0zR/ykf6iluViV64Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=fvajxaxoH5gcrsgsyKWfzMIt4Bks7XaSCsd36afN5ofBLItrSE1jKP7OeHDtC2g90
 xX6YBS1gg4GL/58efyvs6a/6BMQQL9okdaYBlQpXwwf6Pfe//5fz4MiVocVx/4bdch
 8Y8xFXFt4iQZMZy9+cGUrgkltECX2Kiudbya/cmYHL+6xyAL5IbsPoVeoCbAjJ5YNt
 k/ds0flT923XTbQ2mOXMQ9oLDwH9GU94y+ujKlfgK9x7MLszGMgOolYd7+1dBCHWQN
 OcuuLpVeiqELbfvpDRHzqWMGw7dXDhC+2oEWYjxSGiHHnstFo3T1JMG2hrnFr2fU3l
 +CydsgCGn+SlQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jFf321VvpzTNR; Thu, 29 Oct 2026 10:25:18 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 29 Oct 2026 10:25:06 +0100
Subject: [PATCH 2/3] README: update instructions for official releases on
 our GitLab
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-denx-de-removal-v1-2-e71e448a9c82@cherry.de>
References: <20261029-denx-de-removal-v1-0-e71e448a9c82@cherry.de>
In-Reply-To: <20261029-denx-de-removal-v1-0-e71e448a9c82@cherry.de>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Quentin Schulz <quentin.schulz@cherry.de>

Let's provide more direct instructions on how to get official releases.

Suggested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 README | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/README b/README
index e4484face5c0..df9fc9b96f2f 100644
--- a/README
+++ b/README
@@ -57,9 +57,10 @@ The U-Boot source code is maintained in the Git repository at
 https://git.u-boot-project.org/u-boot/u-boot.git ; you can browse it online at
 https://git.u-boot-project.org/u-boot/u-boot
 
-The "Tags" links on this page allow you to download tarballs of
-any version you might be interested in. Official releases are also
-available from the OSUOSL file server through HTTPS: https://u-boot.osuosl.org/.
+The Releases tab (https://git.u-boot-project.org/u-boot/u-boot/-/releases)
+allows you to download tarballs of any version you might be interested in.
+Official releases are also available from the OSUOSL file server through HTTPS:
+https://u-boot.osuosl.org/.
 
 Where we come from:
 ===================

-- 
2.56.0

