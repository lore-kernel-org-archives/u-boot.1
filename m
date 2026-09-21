Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6678EC982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 14:46:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB55D6064C;
	Mon, 21 Sep 2026 14:46:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dLm6Zt3SbBIA; Mon, 21 Sep 2026 14:46:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CBA816064B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790001961;
	b=ODTIa9pPCe2XHMDPw6EdqAt3dkoCduKEU0VKZBloyeTVl3T6G39enO3fcnZTIobWIzVb
	 Txwa/F25eiaLLPbdN3WhuXuP5kn8jCeypU6JXp4tVqZq5B1db1imijHYIy6KNMVWx9L6V
	 yIcOzOulHd16DZ84+CuBRYoNAHl/b07osjd9WibcPoRAm0UGq9/dbf3KuTHJxaW11hOc1
	 Qpy7UDXcQ9ImucSPwxJV58unR/k6hf04TQEfSThHaLrfZytZ5yToOZ9O9LHrTpueANa0/
	 LrgeeSo5EXgTgJs2FWbA2gs5Plo0cch7kJKSrAIZe0djxrWYaTGnuL/githUdkIUo5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790001961;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=y0V/oy+ZjUDJARmCC2uoqj/kNPMFYPQb+oSY/xdNOdA=;
	b=iatARV4Tecz7w3383EPNQbAcVkFIJWLUWbtcHWeoIKetauh8eCmszR5fKPS1kjuOX0qe
	 +VerqTGT/fnTmp7oZ3GCEd8mTQ+HXUCEke7WzYQFaaDAM5buHmHGmYpevXGXVeIgR70+c
	 RLppcmnUVHMxlgecGKqV6SuuZYIdfo1uAw8OXWEk26iKUs7OO+MSJcUrdfXqOR3jt4EZv
	 Y/GZaQDDr6dpDd0LIsdKhBQYr7U9IcUF09QCYRXic0K/nqUrLdbpbociY/OTzmpdeJLX1
	 ytRYvSUtX9sMnq8nPFIkPJuZul1WB/6O+btNQcWiJLQZHSwYufTR3bbv6yazXAvMOIA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790001960;
	bh=y0V/oy+ZjUDJARmCC2uoqj/kNPMFYPQb+oSY/xdNOdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HXaxiRx6R+ZWBWYPZ4iDPDu016hv0b4MiitrRiFrBwgMR1mnMKU61hEzS6GGjJDFe
	 VhGWJ/1wI+qndU3T56Yfnyh+Kgk0Y3e76TQvrKgDfIH9mNiTJ9Lf+Mo/HHn7OoQ5aC
	 7fklHomifrI4H/77Y9ZtV2F6nkkTjLVDSubreKwL8bMDT0fNVllsxngD/YEQGVYeJP
	 xUAxzE6nmLJfVSmMtEzdUL6xUkFHkhUSH12Zd7zfrsiMFH8paZdSvYKcMQocjqPPQM
	 YqzOSaYEzbKjRkwAA7eWdkXqd03ymPWD+QZN3mcpATp0ZEDJCJL6MJ3CJVFg4e/lQs
	 SuKcI1lbStvRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CBA816064B;
	Mon, 21 Sep 2026 14:46:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EFD6D2EB
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:45:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E1B2640829
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:45:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 49xQ3fZ6rW95 for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 14:45:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5806740824
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790001958;
 b=HE/94ACVtsEhzTSCWDhvdFSNl3je920EISYrYbMMnpp4CJvN8MpIxyKdQgJO/zZQuc6n
 VYIYbVIOmypdRARae39WgsvV7F/AIY0g5R3URA2Z3DYB8xh8WOFtQhUlrdWqjGhNfzTTY
 +VMcOK8CxkHMCxzrDYNOhWWDEu7uxOzA5z9rDt9CAYsHySMmIFICZcDc6G+FMofiSCMOc
 k8bOMJ7s2wgaEQurXi1nK9rE5X1EyNx9QtB6ctNuTrqkk5DSPHE70iFCwn4yHAQUE6y5r
 4d5A3xVewxIpoksDa/CTnQ6LTIaQZgOFGuOXUaEpcyVkY5xGncuByrPJhF/aZ1AE4dA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790001958;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=y0V/oy+ZjUDJARmCC2uoqj/kNPMFYPQb+oSY/xdNOdA=;
 b=FB3x9uZQSqsKpusU2ixxcK6QofqT4tiECa9x0KMKTQkiprH26t/F8+eIfR00IjD4BVw5
 KwpucyMkNI8Z0kkVLWBmaD8bKBjEtJ7r5ZHfKoRyfz5gm24Ik2a5oABbjTaY2YvOiHfuf
 Os2GIP57D3I1R1sLCfMl58MkmVJnbxefm0AOQ7KOestwh0Agbr9C7liOVjHteohMhAJVO
 fcp6gjJSTs1zAYXwjFN85fq9KhPRzdrVc+xUvpDi2RU+n4FfChbOTb7uyWbJmfA9oPLTA
 Sk0SJqDUeDlg/cfZeU03PD9DlzMq07LXI6VwWZgVGnUjFbLGXGGxgqr9o9Kb4Qlr2Eg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=YvzK4xW7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:3b::d;
 helo=mail-pz2-x0d.google.com; envelope-from=hungen3108@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=YvzK4xW7
Received: from mail-pz2-x0d.google.com (mail-pz2-x0d.google.com
 [IPv6:2607:f8b0:4864:3b::d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5806740824
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:45:57 +0000 (UTC)
Received: by mail-pz2-x0d.google.com with SMTP id
 d2e1a72fcca58-85469e211a0so3403925b3a.1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 07:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790001957; x=1790606757;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y0V/oy+ZjUDJARmCC2uoqj/kNPMFYPQb+oSY/xdNOdA=;
 b=YvzK4xW7eXz+7zfURlPcAWV5MKAYVq0s2/fVCF2qELm7bZkl0KD/jcHLM7v8yPpCh4
 rgX5vTdxSFcoI761UqDdJvSOQ5KhXWlbPG0h/+EN21ftibC92sVHeg1kXoE8B2NhZN3X
 0gfOLGsZ61O1E6m9thqf8SbyOcwOmiiM8DRuI0JSrpQ8/k+yuafRIF2vp2nrQc9L/n0i
 4jj/1H/YAwQ7DMvsI2fADMJJATujWbd14mc7fYuFd/IDvmEt8DcIJ1f8YdJi2YrIwPSB
 ho+mInhZ3ETtjm3iv2QZQ89K8Q/n0BR0VS0PfXg3NH26gmfbPaoezm/+oxhBtT5PsN4U
 6ZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790001957; x=1790606757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y0V/oy+ZjUDJARmCC2uoqj/kNPMFYPQb+oSY/xdNOdA=;
 b=ZtpataHbyuNev5IsE0tkZdS5WspaNoVXlk3oa2VwfF8OGP9BYEA9KEfhcdEGKPpLVX
 V7d8Zw1mYRrRd31eVshsJZtVi12gBzcIUb5dJB4DgyhsX9B/oggKqbuydUL/+hWUrUkC
 xJDIL0R/SNGo6D8ggkfRg7ziKsewmCWFlFUVSeOj7R2+sBt9bI9qsXf8KfnBP7rTXA8r
 DPi2+yFs5poJkpEVW3UB/Q37C9svWk/aICCInn8UqabbhxnCxvMSTl0WtcpJMEndxzeB
 K0+JPE8vCTW4A7k/8TNNhCqWUZZUMg6zIVVREdniDHEnSGqsvUXdVb+rhBBfNMBb6u+S
 aWkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1z1bIAyd83fV/CzWuZbz4ogxf5kADgO9rHdmWQ1olr4r/dQFNN+EBY5BY9czmuLX+GnD7KF8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kfU1tC23soKIOVlPNgmzKHJLRbjSqujdxgCe7B3gl+0L+E13jQ
 MOvW87xf4eVy14qNoRkpuSGVtMwl7xAkbjC+M9dcOVC96KszLe/kCW/+
X-Gm-Gg: AYBFou0bgDmeniwkPMizFprnHBZP1ecSKVQiv6fy0iahntK7OGFKuKNMlXNX6a5SAEw
 oQ9dg2tgivtZ1vU2iYCE2qu7xOuoPwe3b9Y5lUn+xkIQ3T/gRGc0/8u0TR3aIoXbCBjE+1cTVX+
 sVe1cX7p+3rYSucx8CjVZpVFwd58c48ky3gFl+Y0gd4OoaPnhf4oEzQI8z9fO+o0WDWdJz7Iro4
 R/Kj0ES4jez9uKQM0nsU0l6toWPAtt5Vxrb4lR5TQjf/+cvhMdTHZw3l9XHzB/nGyvFhMukSGkf
 n9oe3SOI86Ep19P5dbuwU4j7szEXpPlhRF8aFUidVJI3vNTG8ID61dvf9w+wq+enM8jbURJBKEE
 wq8qUS1coMdyWvpQaX7/VgoPgEx/TOJFEpPYUY0WrYSb6d/RgrdTB7l4sPpsnyNhE55YcDYvwts
 Sc6dGava/p81hKVFag31Z0DRLBxwWCk6mqysPdtX8766EcDTuFinmedweIR2HZEBOpFEyIlDAkh
 6rV4Xws/djhSfyfUMjuZOUPulRZsAj7FxFwwlbZykZBBaTIPX9tS3TUmFBZDZtilkPDvVWqqW2u
 kmKHIA==
X-Received: by 2002:a05:6a00:3a28:b0:878:3538:8f7d with SMTP id
 d2e1a72fcca58-87835389b85mr8269458b3a.43.1790001957210; 
 Mon, 21 Sep 2026 07:45:57 -0700 (PDT)
Received: from pc130107.ADVANTECH.CORP (59-124-202-175.hinet-ip.hinet.net.
 [59.124.202.175]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-877a8dfa469sm3508547b3a.14.2026.09.21.07.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 07:45:56 -0700 (PDT)
From: Tom Hsieh <hungen3108@gmail.com>
To: francesco@dolcini.it, marek.vasut@mailbox.org, frieder.schrempf@kontron.de
Cc: sbabic@nabladev.com, festevam@gmail.com, festevam@nabladev.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, trini@konsulko.com,
 tharvey@gateworks.com, stefan.eichenberger@toradex.com,
 u-boot@lists.u-boot-project.org, Tom.Hsieh@advantech.com
Subject: Re: [PATCH] phy: phy-imx8mq-usb: add USB PHY tuning support
Date: Mon, 21 Sep 2026 22:45:45 +0800
Message-ID: <20260921144545.291036-1-hungen3108@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921142644.GB276016@francesco-nb>
References: <20260921142644.GB276016@francesco-nb>
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

Hi Francesco, Frieder, Marek,

Thanks for the clarification. I used the older format from Linux's
Documentation/process/coding-assistants.rst. Commit 816d9992d9ed
("coding-assistants: simplify attribution") changed it to
"Assisted-by: LLM". I will use that format in v2.

Marek, agreed that using an assistant does not transfer responsibility
away from the human submitter. I am responsible for this submission,
and my Signed-off-by certifies the DCO.

For this patch, the source is the Linux driver
drivers/phy/freescale/phy-fsl-imx8mq-usb.c. The commit message identifies
the relevant Linux commits:

  63c85ad0cd81 ("phy: fsl-imx8mp-usb: add support for phy tuning")
  e75d564f6466 ("phy: fsl-imx8mq-usb: add i.MX95 tuning support")

The Linux source and the destination U-Boot driver both carry
GPL-2.0+ SPDX identifiers. The tuning helpers and conversions can be
checked directly against the Linux implementation.

To clarify the assistant's role: it helped port those routines to
U-Boot and draft the commit message. I reviewed the resulting changes
against the Linux source, including the i.MX95-specific conversions.

I also checked the i.MX95 TXVREF setting on hardware. With the patch
applied, the TXVREF_TUNE field in PHY_CTRL3 reads 8 for
fsl,phy-tx-vref-tune-percent = 100, matching the i.MX95 conversion
rather than the value 3 produced by the generic converter. These
register readings are included in the patch notes below the "---"
separator.

Thanks,
Tom
