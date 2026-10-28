Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B85606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FKDE89fK;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B4FHl/2T
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 584F680C0D;
	Wed, 28 Oct 2026 05:49:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EN2Z3ZHcVX3v; Wed, 28 Oct 2026 05:49:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF7BF80C23
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166594;
	b=rVJE78C/MCRizfcrnToTpYxlMp3TFL034dZEIvDpumKW8OKuNnnSgO7mut3OXULdHhtA
	 h7VqwAj0lHgpihh1mTGNZW5rhT2cUy7xG8oG4Y2SGW3k3mPUN62HzLpyv2qRD/IjplR4B
	 wHZY1x9A8jL8KPggHy5lyJjj/7KoH8PNDQfMxrz99vu0yAYCtAsJLFwweeSA/GOZYrBAB
	 Odot+5jSebcGRTXdtJsAK5aEWjdggRo5lfRfzCfs4B7oMNO6bfe5ktwgcgXMe5JjAVs5u
	 llVdwcZexp4EjJWlizH1veEWKTWSOrJmSPDutaZAbu/lwJ31p6QhLmp4mmTedk6kC6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166594;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=MSD7mfCeolnahsjnNynbtVk/QAKtnFSrt553NWYUjdU=;
	b=Y8Y+p7zSE0Nr4RHZda0+HS8WvSkyFFxeGi3oRWUTwAKZwwQiKgzjoKPQNP1j3ZStMLLD
	 kTiynfKwKCOuQqILtRkWff7KWwUYCWsMYzIJVAd9SzDZyhFVdQ81yc6/xGFGOZS9XKdv5
	 W+f1FFRETJBTTX45/slk+zwLHbviiMCnu1K/5wQ2o8Y2iUoGuHvNUpIoNzI3sxzhQ1QIM
	 hopfWPQjYvOTaOC37/kOHnFrEo1v0j/v0QVL1LJ9PwHovenCd65NqSYAwL9lpUaEXhXKO
	 ccrdhzMLGlKFjMYzXtZwnyG4CAPIDCQj19O6q0G/H4Kpv+INY8CKhXwMr7JGQ+mRyaw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166594;
	bh=MSD7mfCeolnahsjnNynbtVk/QAKtnFSrt553NWYUjdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FKDE89fKrNrURk/XPBNMXxaqJTEt0PCOfOhKmpobvVM0W0lxF8+3QQGrtKON9AAFA
	 zhppehQXV6j/HzObcgEVGe6JDCnHCI468zxz0OZr7kJH8kHNguk5/t+ADjqHlFPm9v
	 vhgZSKrbI9pT6mHZ8ZCddPfYXMv2N54o2gsW9JUT7FoCn8TlyMw/nMee4AkF7RQZcN
	 Vu5DhgyC5pNsp6id3wwfsmTrEgZtUPrFPphZPJ0Uuag3N5fCzAC6Jr0DQt0tgDdzCJ
	 f9JDz78WWIScEeI5Pp78gerTQo+DpVvRYTI0mLqBbuTt3bBYa8uyq7DQBsb+tnaIPd
	 PSSZg7+D2G8Cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF7BF80C23;
	Wed, 28 Oct 2026 05:49:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DBB28D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:49:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D945B40576
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:49:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GolIEQgwG2BM for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:49:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0201840574
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166593;
 b=Jt06GVS1+VeIDu9VWDr2WXNevWgZ/ABkqxgVotT+dFlNu7SEx+vclp6/LNFshjCbbNx7
 DjipgxdCRut4ntIsjZRANNpBo/uZG/UXJcavPNW9bpoIt6mXm0JNmmT+CjbmG9fWIf+/o
 Nv8jPOdZCwlgT1IGY27uWa9rOVMhnWE+75SyyhuvDzdbz6To9x+jdePieVnQoqW97pX1h
 rP4Pu7takdI/A7G/QWMbqS/114BXEefs8gftHziXEcFZ0dwqXe/g3H9bIbXksy0zEpz3G
 XycNsE0y6tm2vkMSWzMEb2qeQQ0jOGCf8TH2THtr5SCGtMpmKEYWEJhAuCijZc1D2Xw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166593;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=MSD7mfCeolnahsjnNynbtVk/QAKtnFSrt553NWYUjdU=;
 b=VWg9ukX4YckXZWfi67T1pyAxfNK/Cw4piwyFcu12tnjOSliEGYIuRYYmgT1qCjVofa1U
 exOYNIT7yvBS7moqL2nzt0tetTDqYViIO66/sE4OwUH1zMntfTtEAWdWYfF8JlaK6F5T/
 KWf+dZKXTEAM59QBguavhhSrGjxGoA5ePj6bhY5V/QjjVE/56XhFOOhU2irJHmZzGmxyB
 SI6Sh9O4nSe/0VCPmZHe7QxBI6xjLlE/ZHU8Br4oHXrJ7jnPr+ElmhlAKZcNVtJW8vT0K
 grOfo6dYV5iPes+jPQM4vI+PB+ZjIzZvnHjI4LUFPsNW8QZ6zBBvxJUHEGS5b0Gp/cA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="B4FHl/2T"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=B4FHl/2T
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0201840574
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:49:52 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so4173335e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166590; x=1793771390;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MSD7mfCeolnahsjnNynbtVk/QAKtnFSrt553NWYUjdU=;
 b=B4FHl/2Thb7W7yHYewmd8DJPxA7yqEWbxNrSCoLYmg2+QJjy39J1xdxc/kQ3OWQyqp
 Gaoe74ssWFe04/CWVoFRft6yPobDzd5ws59z0Nk1pgfsURrr35tL6JYdi3utXA/qZr0g
 QViePvIEV1ttZRp4eFG5cUzOkE9ww7lpLzsKSaasOfOZNiH+39Hd9feWaLjL9Mn1u/u8
 dHu4h++fdU4GxR6cDqyLcPZiKKk4AJMUXmkvVpVXdEzSKp8KqArTCxvIPd1Usb8ybvqc
 zxb4uXBKkixrddCNLQn5U9sDLbR8+zCUrdTtC9qqz1py1XGSYT5QCFkl1F4L6561jVNe
 qGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166590; x=1793771390;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MSD7mfCeolnahsjnNynbtVk/QAKtnFSrt553NWYUjdU=;
 b=oH+9X/HoJTU7SiiH81gy/qZs3jOOQnU9VLhKZSzg2/wjomSYCdFUMUJW2hFkJbqFes
 zw8h2GIOTWRLAHP2x3b+wJSgCtVef+dR/lHiGOLpxAJYMBMPnesDvnxtY+dbXa8jVLYu
 S3b0v90e+s8acWboy43xrgWyZ9NVmIK06v1Zx8ntw2rbsPK1lzcFlGPKHCuY8wI+5u2A
 9Og8nmFv64CRO5762t1qiscrm/bF9VhwaP+v7/Z6yaaxo5Xmw2iBCLX6QQKbdYxrKbFd
 ermryGCVEQKCIa/RS7R8g57xR2eQE7kI5PHTu5pjY0dyNVE92bcwQk1s4OUgFsgtN+cE
 f8Dw==
X-Gm-Message-State: AFq9FYJoL6nSfxqjDK5oimAWUFfDaHu2H9IY+BJ9cAjIv2SL5orIV2O/
 LnciI0jXRZMAWA8XBm6F2DkAunmBghgTI9njuYW9+bi3+F4O2oRvLKHTHykxcqpMuHA=
X-Gm-Gg: AYBFou0CKhU87HFqSteC7uiwqs4ZZC44v562AS+ntWnoC98kygoHwq8MJFTKBRfsdCV
 3xReUAky2EUQRtnW+J6ua8ukn9DKz/NEBr+woPMQWo0qE6rlgC/fxojs007oWJSK1UTibWJVtag
 iczTPSmMa9PnTbvj/38AqZpMomLWYWHnGN7YMa7/C5ZdK8JDFfusPoSU2JPNDldUf9PQ+00vsMe
 N79Gk3eCkd3Dr/TeYxk9CImoTTcWNaqhnldeV7fDQqttOkpDWBVsG0rROO6njHU+j3oy1tFpx+y
 jiIIYEZmbTOonYg8xdt0yXUuQ6y5rN20MjOE+wRCTMyiSdUxVdqHK4Sldppe7+BcvsJ8LIbLUJE
 0wHnlQmusrJeFWWRvWwcpBzevQHmG+IKK00yNlA7Uqrjv9FlDad7ds4v4ds3Os6wx83TU8DTrO8
 5FZXpt8vVr4bMiN+43S/Sze6XCSWtm4BrkYR2MWdR+msiOjyMLvTi2KyPAKPMSiUrEK4cd2ByGh
 mP8PPhNh8rBro5Tcf8x7FwL1rTgViQrKUv/kdJ0INp+7JTdZhrh/vN2z4+1Uc+IpO3i+qxeIkZj
 845NAzCLUjLbFIDukoVQJ9PuEdE+BsQ=
X-Received: by 2002:a05:600c:a103:b0:4a8:b8b4:6226 with SMTP id
 5b1f17b1804b1-4a9672f8581mr16106705e9.28.1793166590386; 
 Tue, 27 Oct 2026 22:49:50 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a978d57b39sm33272485e9.10.2026.10.27.22.49.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:49:49 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/7] efi_loader: capsule: check the size of a capsule file
Date: Wed, 28 Oct 2026 05:49:47 +0000
Message-ID: <1b7446d7-f376-4045-9b30-efa1a892e156@gmail.com>
In-Reply-To: <ab256ba2-8572-4cda-b7da-45b2c0368beb@gmail.com>
References: <ab256ba2-8572-4cda-b7da-45b2c0368beb@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

efi_capsule_read_file() compares the size of the capsule file with the
capsule_image_size field of its header, but does not check that the
file holds a whole header first. A capsule file shorter than struct
efi_capsule_header makes it read past the end of the buffer it
allocated for the file.

Reject a capsule file shorter than its header.

Fixes: c74cd8bd08d1 ("efi_loader: capsule: add capsule_on_disk support")
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_capsule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index a77810fa15c..54c118736cf 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -1190,7 +1190,7 @@ static efi_status_t efi_capsule_read_file(const u16 *filename,
 	/* fetch data */
 	ret = EFI_CALL((*fh->read)(fh, &size, buf));
 	if (ret == EFI_SUCCESS) {
-		if (size >= buf->capsule_image_size) {
+		if (size >= sizeof(*buf) && size >= buf->capsule_image_size) {
 			*capsule = buf;
 		} else {
 			free(buf);
