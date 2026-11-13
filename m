Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63880606A882
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 22:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=y/4puP24;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E3Qga2Nn
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B549881A47;
	Fri, 13 Nov 2026 22:57:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gW1Gda8PBTdK; Fri, 13 Nov 2026 22:57:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0D6C88198D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794610671;
	b=ZI+szVb/VudLDS9jxjs9z6CPLdapUGMWrNc/fc+fQg4uVktYheM+r/YgU0DFVr9NP6nk
	 uS9kYoeb/7943Bh5DHVctEzBXXqxdlvPyEqKOgt3enBo6+hEa7LRTVftQCbIbZvC5OTFK
	 +QBIEgnmGjwfflzqH6xmlEf83hRsW7rgM0kHkpue45y1+KA95/De4wvNN5NcCgMq5ZPBv
	 ISQl7iDAK/b2nK1jPARPp0crLQnogha8XiWQqbGh6TTbnROGuNTYveDdqkhQYII+C9210
	 1HcB28zLlg7DCGs0rjGZdbTfpYAGZRdM2bF8+E3eWOOdfPsj6TdLKnbPbEHTe7tzSGA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794610671;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EsY5puNrUbtJP1VwDMBc+1rFJtNO8vkgOdyGQJHnejA=;
	b=IJ2aM7+QCdcii5M5es4K93pHnOGXGPA8DJqj9flEeBxZjFrsG2RZzZVZTnlOkka3uIIH
	 KR4mItqO7YB4H+nJ7smbB+SiiQM6lZ0VR0Md4NOqfJ6KqWDlyF3jlc4bgUtT5dN+Ws3kW
	 M9ys2WGpWQpJv0VpCt8DnLOMKRfflNbiwKZ4AvM3lu3e4ctoMHXHScB5pHfoNzh8TbDZh
	 f4KFaR73vuIv8oqjZ3yrPEh+MGpM4khRM77k/rOyH4EXaiN0KijrwjXbJLEj4RQZNf1/L
	 85GZ38z3tkj8nyv/WoNTwhM7oPElU6/U3QmeIsOqk652Z8P2kYQ8gc8IzP/xehhIqsA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794610671;
	bh=EsY5puNrUbtJP1VwDMBc+1rFJtNO8vkgOdyGQJHnejA=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=y/4puP247KQKdQrVuLjUJNz7iUT0V+4rfyPQ6p0FHHBvyE3TpaVi4EtOR6onKVb0q
	 Fhkhj17eXWET6zo9q2RtwXxSc8YGPwjBNlppyAAYOHoGx//hvGUaceNcDKabwIB2Oq
	 k1jIcagVTDR6WiRA6z/e4x26XBOiYvwt0DKCaNiQA/ui2c5uuaj0lRHdioQ/cAt46E
	 nTsGFTC2pEbGKXXIIGrrnBldRq7W3wbhgA1gcmLtA8EQ7jE1EZEBCTttm7Pg8geoz8
	 MIYT0AwhrMk4FS5J7j7iv9dM/uIQoa34ScWdzNnlpRtjTItJmSk++gGIm1fz0UEl3w
	 CmHFHb+x+OMXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D6C88198D;
	Fri, 13 Nov 2026 22:57:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 843F61E7
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 22:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6AA1D606C0
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 22:57:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OOCw93WexkAq for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 22:57:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DBD2860669
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=E3Qga2Nn
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DBD2860669
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 22:57:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A3ABF43B11;
 Fri, 13 Nov 2026 22:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AD11F000C7;
 Fri, 13 Nov 2026 22:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794610667;
 bh=EsY5puNrUbtJP1VwDMBc+1rFJtNO8vkgOdyGQJHnejA=;
 h=From:Date:Subject:To:Cc;
 b=E3Qga2NnFBGEDJIP0QnhixpUEBdYl5IPTV2hhTiddeUKWTh87A08bj/4uqUUaK5yC
 kvWu29I5Bx0ienNqrlrD4yJuoyu61U6VTosLW4gEEj6Z5ON3teTIiqK0vfNtY2/8j/
 zMqAiJ8G1h82MSX9Fvl4cULzRpAdMqEyyMMVKRUDXZYn4m1/HNO0+I3AlM7ddKmuhg
 9duKnP5i9SZVYYgh0vZ8LhwpyCtveCdRO7EcH3I3s+/loBA5uLR8BOQPg3G5K5Rd4s
 hu0kcWnnI5HZskT2Drnnwv9zDBYiwrcMv+m6SoTQeCZvCr/9tOocF8LN54UGMygDPr
 kw8x+J1rwYH3g==
From: Yixun Lan <dlan@kernel.org>
Date: Fri, 13 Nov 2026 22:57:40 +0000
Subject: [PATCH] MAINTAINERS: update email for Yixun Lan
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-01-maintainer-dlan-mailmap-v1-1-60888ee6b978@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAxA0auQrm1CUSR6FcOiTjtSAyOZQWNCu
 DsDLP7ibf4MSaNpgnsxQ9SfJfuEDDoV4DoOL0WTbKjK6kpEZywJB7Yw5TSi9Bw29wOP6B3Xt0b
 o4kUgD8ao3v77/NEeTt/nW920HWFZVpzZ+V1+AAAA
X-Change-ID: 20261113-01-maintainer-dlan-mailmap-fca597d14fdd
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=869; i=dlan@kernel.org;
 h=from:subject:message-id; bh=5S/xiDrDn3UqQtI9+0me722QblgRrB2VlWfJstKyEmU=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBq95Xn0TAEy0RNuZZ3IObYn2xR6pV1t0m7tE5/B
 p3eFxCzlMeJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaveV5xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1Z+g//Stn/XqWhSqWnewes4gAz8slxtg1oUQ8pxJ7ULCIV1rqZ3ONYOyOiI
 4rk0etanGPkejrtRs7KylZNOjrrBG+G7hidVbv70o6q8KjKMQmwJ1GKy2T6ylsy9Ibv5b6Fkfr4
 Ns+oRgl1/g4CH9zjcjdXndBS2GLRLh7b3lihl+6PpO8rSbHg2//rGgM21jbjKelXhIh1cQTPPFe
 CboNVDcRL/fsHRRFk2Hn/s9LNCfDLMz1akwg+xaSF3SB58hpt183Si6F7HrEx0RmghsqXn0c6P+
 o9YjJr9Y4sRRq3foOQ1lDsa6z4KaGGsM3hNx7rcjMAqiIsqTHvEkqG2v1yPsQ8wS3v55Ni7Ar0+
 DgmUQX1VMaOy2Sm5c4YMJqOReMv+E9oGoBSs/g0d3iK2Z1BAQwhs8QD4fc98WfAu+WnxqTLcCpo
 OBdh01imBqA2DqNPUIw7dL6ADVrcYCeFLcl9FKiWcAO8YXglfn6TSUONXp1guC2XRa2XiDJURwW
 MCxf3xnJ4CaiYmsFFazyoB12hSGIq4UK5dfcFFtVD2gJVA7MZr07jiiRCnh4EJneagVrXyCoHit
 R9yTqiHVIHNHUKduCdEQ/sqHvdM164vVRgsaRd7vT/WzpeqEp/GAX0wbRv6vkGtGwU9twyCyuoa
 NBxsNZHzIuZ5716UVYOJ6lfsxF8/tw=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Prefer to use kernel.org mail address.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 863a7dda856..50aa6d6dd2d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -176,6 +176,8 @@ Wolfgang Denk <wd@denx.de> <wd@xpert.denx.de>
 Wolfgang Denk <wd@denx.de> <wdenk>
 Wolfgang Wallner <wolfgang.wallner@at.abb.com> <wolfgang.wallner@br-automation.com>
 Yao Zi <me@ziyao.cc> <ziyao@disroot.org>
+Yixun Lan <dlan@kernel.org> <dlan@gentoo.org>
+Yixun Lan <dlan@kernel.org> <yixun.lan@amlogic.com>
 York Sun <york.sun@nxp.com>
 York Sun <yorksun@freescale.com>
 Łukasz Majewski <l.majewski@samsung.com>

---
base-commit: d1d45c926a571fb6c1e6d7105c280833646915ea
change-id: 20261113-01-maintainer-dlan-mailmap-fca597d14fdd

Best regards,
--  
Yixun Lan <dlan@kernel.org>

