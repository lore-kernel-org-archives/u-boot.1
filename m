Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E703ECD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 17:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BDEC84DB2;
	Fri,  8 May 2026 19:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=vulncheck.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=vulncheck.com header.i=@vulncheck.com header.b="NGDXybVt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C0DC84CD2; Fri,  8 May 2026 19:21:27 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A8EC84C33
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 19:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=vulncheck.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wsparks@vulncheck.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-38e800deae4so16074181fa.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 10:21:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778260882; cv=none;
 d=google.com; s=arc-20240605;
 b=Yqrezoi0F9F9EubeLiQ+7KHpVEa+FCuK2IVp1/H9JxLKhekA5lQlTsscQvM0oHRd7w
 Di2zQDwvthdyjUAd2y6dZlfN8y0PR+kkMGrBcbIEjHBQGAXQTk0H+xUVwzXyS1oNHksj
 IQENnuoUa6Khu/3Fa+ff0PnqUSy4466JvEej2O30q4bdHsABxSCb1IZGCM8raZMeWeYr
 X5hJnxtvs+QBCiPdgkqznwF7a+cj0BBoeEt/NhY3TD2pnYCqeDTuk6nc4rnVg9T6347Y
 unu0PCWVpvfoj+85BsR9DyRioOQwbPBaTIu0w6D5s++kIqRfAMY2NNJQbqVKHldY47vG
 bqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=II/10AaR62FSB29E/XCtmXNX3qeZKAHrjn7HfR0u/S4=;
 fh=kxlFPbI2q7m+Vs2RJrhkgvnueNeQ+rB+HvMQCHgw9I8=;
 b=RkrSNyADABUy3VHDehAmiTPvJDMjV8lmqLDeO6dtHqZkho+thVvTRnSJeffahBFM7j
 YqDkpmDX01wwdion3f/o0UBMitR7DoZuKeXOoV1OpxX+26rB6A48C+am8NAKc7KRodqO
 aOvYXvdVfVEwd4wk5V/eg+AdObSYxZQqKROPZ2RrF1n/TQYlqc491mkCxI8sAKZO3eOD
 HotqFEPFc6y6JdyEmNYoEAW8CDkvFUFFif9LAedaWEZ1lteC/4KC3+mvqT1G2ogJyWIs
 MRry5Oa2oIlwKecyfzwRPbJDzrPMqiSNKeRC7sPlZU8B/3cSGkSMBleBFflgmWbc1mJB
 qzag==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vulncheck.com; s=google; t=1778260882; x=1778865682; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=II/10AaR62FSB29E/XCtmXNX3qeZKAHrjn7HfR0u/S4=;
 b=NGDXybVtE4Q27oYD7y7xU6TLvJDEOHj5vvhBWoR691RtwzT9//sCIdMNXVRmVnTP/0
 8BKE0ClH5n0V4GpQ8vi9QeRGhRDH7AqR45Nj8GJP40hR0vBYV82JPYSZgLaEYrEm+HAZ
 ZoGAFMklprEAtXBm8AtMFDdDlEonG6QAVur0MQZdSTsgc1wn40ujK0MMUtKD+rMyWy1y
 UzyDnQaupZHOSegefS8PXP2+gSV6NcQJ7n/zZSO5Qdonu58IWi6KLCRxC9dFmmPOSTsM
 ZYBBLBHJp6esUPHlacQVUnQ0aF6WBZ6sSx1KUs6FW1tXNkii53x7/8YRmJn/MQ4wO34I
 /1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778260882; x=1778865682;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=II/10AaR62FSB29E/XCtmXNX3qeZKAHrjn7HfR0u/S4=;
 b=Jd1LCBKNHu5n4y8hQjm/rXALANu9x70WPLJlYLDqhQRJBMWi4XYDuUN9ivRE80e2kw
 ZHTCkyBJCP9AVnYWVDdj/X46w18r855WB7/W1PX6RVlBi0TanS9t7ccAiPgn0aY1x7po
 xT43FI4uizXkn0yPVppVsTmSkWeORz8v4vxr6MUiAGZGoyeknSQDjzmccotSEEOfPMiC
 9bKuQxbvAJ9dJq2vfHMr7ev1qiqF1joDlbPCQWnYksfGI1ibBttat56KP8JIsG9idd7C
 J0KF5sQ21P8Kqz/BdAUCiGjVthVWKv9fg4CN8HJt1n0tAk38F9mgnfGLAMRZN8veG/XH
 JBJg==
X-Gm-Message-State: AOJu0Yy5IB2Zir6ahIfJK+R3pWZlt72Bzqq/WHW0hxklheLuPI2V5ymQ
 9rXpRncx7+qPT4C/zKTEcxftNTIQ14JbsRGPbMt/iz430vwsJvL0IUE0JXIpqb9Jnw4ZrPq48nP
 RcGh2FCHQrXZxO5t/RTExb6ceY9WUcEYZzNOXOilh4D6N+WzPylgE/wA=
X-Gm-Gg: Acq92OG0RbB9fmzKTFFM/mWS7w9Es7JncB6QiRRuImCAVRdxQUM4kyTtXv4nhJyDA0T
 1TxWoJY3RA6x09lBWNo5HvCRrGev0Bbonv8F/XnxKUSeLjlFM6SENcSIa55zlI91Vz19K3bxTV6
 9Ku8WxRvBXOxaB52QMrOMiNCS4QSSBck1ZY/BFei4mgAFJJ19xazUCUGUqHoENJ/wMQGtv0nz5j
 QcrUJ7HSo6l2xNMTkr7ajonijJ2psH2ozj/hnmhOt2TU1rlj8ksz2XXWF4tikmK075483J/Rojf
 F2c45n6DYEF9oCue5buFAfibYBuiI9cvmq+vfoE=
X-Received: by 2002:a05:651c:4194:b0:393:55e1:4bcd with SMTP id
 38308e7fff4ca-393c4367d54mr43007231fa.31.1778260881644; Fri, 08 May 2026
 10:21:21 -0700 (PDT)
MIME-Version: 1.0
From: Wade Sparks <wsparks@vulncheck.com>
Date: Fri, 8 May 2026 13:20:44 -0400
X-Gm-Features: AVHnY4LQHQXH3o3b4B8DNNbW8LzfOtbGYx9-jfqB3odQEsHfJtyvwfLmLtJlHX8
Message-ID: <CAA1v+SgpU6iU_WZFWN4ft1NveJHM47zSk+KPLApy9hogOKDe9A@mail.gmail.com>
Subject: Coordinated Vulnerability Disclosure - U-Boot Multiple
 Vulnerabilities (3)
To: u-boot@lists.denx.de, trini@konsulko.com
Cc: Disclosures <disclosure@vulncheck.com>
X-Mailman-Approved-At: Fri, 08 May 2026 19:24:23 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello U-Boot mailing list,

I=E2=80=99m a vulnerability analyst at VulnCheck <https://www.vulncheck.com=
>, an
exploit intelligence company and research CVE Numbering Authority (CNA),
where I'm one of several folks who manage our coordinated vulnerability
disclosure (CVD) program.

An external security researcher recently reported several vulnerabilities
<https://www.vulncheck.com/advisories/report> impacting the U-Boot
codebase (discovered against release v2026.04-rc3), and VulnCheck is acting
as the intermediary and coordinator.

VulnCheck follows a 120-day disclosure policy
<https://www.vulncheck.com/vulnerability-disclosure-policy>, meaning we
afford vendors/maintainers up to 120 days from the time of receiving the
report to address the issues before publication of CVE records and
third-party advisories. For these vulnerabilities, that 120-day deadline
falls on *September 5, 2026*.

We have provisionally allocated the following CVE IDs, which have been
shared with the researcher but will remain private until public disclosure:

   - *CVE-2026-29007* - Out-of-Bounds Read in TCP Options Parser
   - *CVE-2026-29008* - Integer Underflow in TCP Payload Length
   - *CVE-2026-29009* - Buffer Overflow via NFS Symlink Chain

Please be aware that none of this information is public at this moment and
all parties involved are considered under embargo. The researcher has
provided us with a comprehensive technical report including reproduction
steps. Once an appropriate point of contact is identified, we'd be happy to
share those materials with your team.

If interested in VulnCheck's previous disclosures, you may find those here
<https://www.vulncheck.com/advisories>.

Let us know if you have any questions for us about the CVD process or for
the researcher regarding the reported vulnerabilities.

Respectfully,

<https://www.vulncheck.com/>

Wade Sparks III
VulnCheck
Senior Vulnerability Analyst
