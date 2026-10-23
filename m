Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EFB606A319
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 04:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UpxrZb1e;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pbrM4EOh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 037926063A;
	Fri, 23 Oct 2026 04:59:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9UgeWJIoR8kZ; Fri, 23 Oct 2026 04:59:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 36FEC6063E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792731554;
	b=ofIgqqc5IiKoScS3NS/d/YEmLv/6283DVvvs7GqL1bGOj3kUi/KFbLTwkMwmbea7Bbdi
	 V7TJIH7nL3HkzohGxjYIRNNR9TBsndDlMaDM7BuPWYydS96JLn92GtUTSZGyzqfjlUwsW
	 1aLnzt9lR6i+o1xZobwsDC//KL8/fgReDi2keyUviS1fbQiZKb8eGqn+FCmN4nUuIQ36n
	 deN1s2B8gr+pEFA9anGaoMq4nxOCjaEhQvU5Byeim8tL2w+Vz1yRr7/P6z0D5KiwpOrWg
	 /fA0KJvHR+7xcA2uY9sF3DNnc+uNVBJbmP2VIAaqQzW5+GIv6a6wDarteS3JhbdpYrg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792731554;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eUXVQqFDDPZXLOSWudKwvpSJf5EyfSLvc2NJFCMDXJY=;
	b=BL/bv994gi6YUaJxenDPFvoI9WKDkxMhnnfHx63bH3FbtG3v0jGyYHrANkzNrLo5TSf+
	 nuJlas1h8AXyEwRm3JNQzKWtsj7wAqNYteZ5wPOHFJom81ZZKqOCLdMvrf1GHP74mzaNa
	 wWBGxQK+gDDSFOL++ruPZoXeK+0vigi7RD2d7gsp+hd2xmhOl/EfFi/5fjjUqGy03PEWW
	 Nmi11urV1gYq9S4ACbcxyyQVBXOoNlGuAmZLvuq8zkzFWck1aWA4xY61ChdeILu5EVdrS
	 MRIcai5genz2ArC1IJ6r6x7ezdH3QF7gUWcpqOlBM/LsDTEfy6YUiBcVUTyp7rawF6w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792731554;
	bh=eUXVQqFDDPZXLOSWudKwvpSJf5EyfSLvc2NJFCMDXJY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UpxrZb1eIq9uECsL7AMLvYzoQuX0FyZoL5dbVMO8ks8au5XnddESpp4qo9/CLRINQ
	 DLpvo3IfxuFcZaqrJ7EClCIufF6xkAC/8QpDuMB6xKttBOiejwwLBpkX2tUrS0t/Ly
	 rUhtjbAwD5Lkg9749sOk6MnfNxW06YmYZBLytGHcUlf682ASWJWOWr3UsndgeyzPUE
	 5VpSgv3M4RuWU+tRh0RzC75yUzrY8HxsCi0UYtQ/avNhPcP1RF+gwL6/0kZwn5Cc8I
	 7vg6rYro5gWpcPzf6ukTR/7AT/JAOe8XPj3b4Hc9hbqeyRUXatMFaLUHv22MMCnvc2
	 AkhClyvmK4OVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36FEC6063E;
	Fri, 23 Oct 2026 04:59:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C48991C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:42:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5DDEC811CB
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:42:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p9OcZyAMX9Vn for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 00:42:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AA8C7811B5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::22c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792716178;
 b=jcrHzxoXBOpnDgFNWSvM89Z4tVFi/sxkUeqb9jaFZrh5YoaBYH5QMgX8ib1LWMj5wb6F
 0QLd9ZcDlwDOmeFNbFpC9avlky9FJLYPqsWkwHm0wL/HEdze9AfztynFeF24euCyz9Xqo
 N5drRmnRE4D7Tj2UkXbZusgBJCFcZsMKAdnuxH8j6/7XjxoLeSrzSUK5YH+bh1+PUo79D
 cQcwHA0eGWpptm79yF1Zy1C8fGQ6JZwN3q5gGQ4b79dZNx61gfXqdXrMxMp0a3ijqcfM9
 yxowzPxECzGKly51wUIWaFd4rvWJ2br0+26svgoE/6RvHsWB1r8Iyq7YnQJoAk6xvVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792716178;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:From:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=eUXVQqFDDPZXLOSWudKwvpSJf5EyfSLvc2NJFCMDXJY=;
 b=mi+doQ0hED9aZ6VZbbd4QwlJ3BogP624Gj24d1RQPIE6A2oN0cIsbE5Fe+eSV8wY1J5u
 qVSSm5eQYEuALnrsvk4X+ZTiJWzD8biTSAJWjEXb1pbVFc4Q7ZHWIqDhjegUjJb9KC/xc
 tGTu2w8nxugT+TjCzXqMoSImkPjMGAl5/YX5VivcQjOV1jYe20OOfHeOfjJoNhF/zsJcx
 TzwBHZ5Gu7mHKSkrhzLSA9VhbFMaCnJyOVD0Pe73bXAmbMbMouB8ZCoMjRlfzYvOJCMya
 3RaMRSnwlICOX7fDII7AssgDTa252EzdQCeNFmXZwWv9X2Va3dUS+ePv+P5NSGspvwQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pbrM4EOh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::22c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22c; helo=mail-oi1-x22c.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pbrM4EOh
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA8C7811B5
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:42:58 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4b28d9537bcso207633b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 17:42:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792716177; cv=none;
 d=google.com; s=arc-20260327;
 b=rX8JLXzOaA5PBe2tG7ob7Weve/HMAtPsgKchHgw67RSt+E4Tbr6wjZU4yeANie9JiZ
 koUmetKe7JH7RK6vChu3MH8yFuamGsbKxNtzpRX47pAVT4lhLkabs3GD/gwzwiWk2PjL
 yjtOp59GjhmyRdJmtTv9NDiUVjC8vWht1gCZnsPx6X2vxYAVg2CJxVWKTnzov+JvUn91
 urp+qtdZ2WdqqNzV7ILiZ1tY1zM5aDG62ZKjmfl6nfMbZBSneDSLpnNaU/9RxsqFAwfx
 5AIuhf8mgahGiuTYznigH518YYsXyfc3rUeZDtrFg0cS7t3zP6+Jt9vAuFBExGWBIje+
 Rj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=eUXVQqFDDPZXLOSWudKwvpSJf5EyfSLvc2NJFCMDXJY=;
 fh=TvOzISRimkiNnHu8M+59h372bt1FP0ZTgMORv6s6qzQ=;
 b=KadSqvZouIhbIqeU3aPsXnQgBeI7qezBOBw0Tq/gWYd3DQ/7De1hxuZxAJ7FOW/Bwe
 2Ll/PTkO9tK1VrY5s9QAM/hT0FM0yQqQ//dylZMhCGFY7Tq04XCl4bJq+xebBddYZOtf
 2oZFp2kI5YbNSrmC4mpTDVrnuKbkvxHGEa+dvgbhRKS4cM92TTxtaSxfZx+3+4yrY/WF
 JsRoguTnGeEcnCLMQLcqyE++pGRgsfMdjSUJhG38z4ZeFXWMlw3XTWqmVrhgV3fGsMqT
 XebLFKsUQSnNQf+tfL6a0Te3qMnvG0KCsBv0446AuYestAh/CAPAT1apy9Re9Ks6vkLC
 LpEA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792716177; x=1793320977;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eUXVQqFDDPZXLOSWudKwvpSJf5EyfSLvc2NJFCMDXJY=;
 b=pbrM4EOhuiGMVaejBrjZuGmYtx0HWhFvuO76OIobiE2G7LdZIfT6D1fUUgBYqe/gxt
 Q/cKvOvPCVuPyg/bQcRcgAMJKm8oZhiPPVc0bWsrBy785v8Lz0pIj7ZAzuvQTuS7iVBw
 BsrVxty6Ihqsj6CW1RMQ49R7gnMQw72zqSHynGkUUpHZcsofxz9Er6r4rJrxA8gynhza
 WGO+JHCu9bXDZGGORAuQ9dLYTMoKBI9+meZ5D+OQIU0O5umxRlhXTflTCeEP8N8lulEq
 o9UmO9b7QGfVs5FyCGXn+6Z+X6Kmd1jLNSiDhpealr1wCjYsQ9/tlmwJSRNv3edNRT4k
 9i+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792716177; x=1793320977;
 h=content-type:cc:to:subject:message-id:date:mime-version:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eUXVQqFDDPZXLOSWudKwvpSJf5EyfSLvc2NJFCMDXJY=;
 b=T2QmZmKQik98yi8b8l+omk77Afvt8taNiI26ksTOj9kfFbhGz4ZmbD6k6Yg3IkwsRZ
 cTL1vd1x/n20nASPWegVCAfVmpqvXZ2QDD/fH66HER87K/wjWtLsKMvCmXogpqYu4Hsi
 2QME3i5Cd4gCoFjK/FoKMY9RwLH2Rsb0VOVYYImiCT+9pztyEGAf9k+h4gctXCycu/eU
 /krTZ2e9CwvEOQsCWiOkL4UcOJ5Rl/jYPlxtZ3+KbwpQbnINPLZhZAi8OpEUYbo5kk05
 ddKKSGQ5m9Dj/CIQJudnW6+S6VR8ptzYvsWn5XEf5ObHAeOt4xx0YNykmDe/RJsASX4C
 AJMg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6u3GouIG8NWkBqLaNU47f+pix0zfxVDNso8wj34NmNkfJFYpKR/j4I4kSJrZZVs/Erzoqswk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJB70XQgxxLpzJcETyGmIOjS6iXiuVHgJBCrmTs4wq75101ucHb
 Me6atw2iZnApJz2/U7m7ijERJ7x2RN2196h064JzQ6oST8NsdLcrE38oYLdKom+ZCCysjkYE7sw
 ZOdhR83Kli7574ftBws+5Xwt+xIfFGE4=
X-Gm-Gg: AYBFou0Femiu8exUzwPDMOHfrpAbKfUDOBqmbv931eVz+XBkrUnqD32K/TkNpio9+3J
 vjJEIq8vxxoWk5NCoJGD0Nb1VgH5ffjO368P/D4gU7BTJd5ghfCVVnx2LE/3gBS+ZXG3pzl3mxM
 yasfg+k6Stkd2JNvca0gX/IBQ+kJGM1y2OlnAXTgJNxRUo7EMLaudQIs1FdgMOtjyjzqzHfTc3F
 ifKfTibhkNofDAL4/NYYj/Zv+2ThfwflnAhEhWB9dn7MSG+hAal14/wTbvEiyQbhMEGJeY8veoS
 PoZuCTcxViO/73CHrBnDKwcLCJJsxS+ENStqjO6/LMf8jTPM0COG/IItXVuYaSOIM3jQ+OXyI1c
 rJ/EDBIqpzHPIdxxi01z/Bww=
X-Received: by 2002:a05:6808:1528:b0:4b2:8dbf:ffd with SMTP id
 5614622812f47-557ddff5ea3mr2178503b6e.1.1792716177142; Thu, 22 Oct 2026
 17:42:57 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 17:42:55 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 17:42:55 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 17:42:55 -0700
X-Gm-Features: AclHuK_mGbd7RoDk9IlIoAvYL3myl5BNsMfym9squnYyydC0OQpEvVq6NkLkj3g
Message-ID: <CAJnxHsh9KDHJJFK5Pf3A0JUaNb0bK-hDZxzGpx89xMJ5FiKBLg@mail.gmail.com>
Subject: [PATCH 0/4] usb: eth: Check rx header lengths in r8152,
 asix88179 and lan7x
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 23 Oct 2026 04:59:12 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Three of the USB Ethernet host drivers take the lengths in the headers
the adapter sends with each received frame without checking them against
the transfer that carried them:

- r8152 reads the rx descriptor before checking that one is there, and
  its bound on the packet length wraps when fewer than 28 bytes are left.
- asix88179 bounds neither the number of packet headers nor the packet
  lengths, as Linux ax88179_rx_fixup() has done since 2022.
- lan7x checks the frame length against what follows the first 4 bytes
  of its 10-byte header, and lan7x_free_pkt() steps over only 4 bytes.
  On LAN75xx the length also counts 2 bytes of padding, so every frame
  was handed up 2 bytes too long.

An adapter that sends a short or inconsistent transfer then gets the
driver to hand the network stack a packet that runs past the received
data, and for r8152 past the receive buffer.

Patches 1-3 add the checks, one driver each, following what the Linux
drivers check. Patch 4 adds DM tests that bind each driver without a USB
device behind it and feed its recv() and free_pkt() prepared transfers,
and enables the drivers in sandbox_defconfig so they are built and run
there. Without patches 1-3, seven of the eleven tests fail: the short
and oversized transfers, the lan7x step to the next frame and the
LAN75xx length. The well-formed cases pass on both, as does the r8152
descriptor length below the CRC size, which the old code rejected
through its u16 wrap and which guards the change to int. With the
series all eleven pass, and the rest of "ut dm" under test/py gives the
same results with and without it.

I tested this in sandbox only; I have none of these adapters.

Jonas, your series "usb: eth: asix88179: Use a fixed URB buffer size and
misc cleanup" from January bounds the packet header count in its
ax88179_eth_recv() rewrite as well ([5/6]). Patch 2 here keeps to the
checks alone, so either should rebase easily on top of the other.
