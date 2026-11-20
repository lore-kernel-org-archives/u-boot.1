Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9124606A69D
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=q0rDBL2m;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zKG8kJ7z
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85E2881331;
	Fri, 20 Nov 2026 22:08:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZLinvlh2Gf31; Fri, 20 Nov 2026 22:08:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF749811F7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795212500;
	b=Swkr1bsARHU8YvjsvEUOypTP4A41EV4PQJA2vTaBfcRSKRtr3y7vZCgLBDK8HxwOrxtd
	 usmiGlLkqs3ZwgrYG+bMNGrjS37I4hQPmeY0AJkkLafmX2gJg31RiUrxQJBjlo6rmCsmV
	 FHIWHxUVrBY3DCEMJulOLXOGd8AtgqSP0felo3P302CN7IQevTsFNH5AHmjSFgTlPXh2u
	 CpmCcmItOEl37oJ+vLKXrf5jL8+nR/siDI8Ak0l0vlEMDSHpV4EMZKUEdEZ0AMZLTk1J4
	 juemOVW77EDc2ca9mqhnMV8n0VSLc1+MJyoEwsPbqFok9tGvzxeQtg4fDWZHFitFE7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795212500;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:
	 Subject:To:Content-Type:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aesx/pFBQichM7IPvpkka+4T8BAiu15aejMTw1ZBSSg=;
	b=iKNpDb44RQVsaCVhUXM1nMVZunjoUdE+PvjE6LUacZ04OvsCDYNIg4SdSYvUqDeM0Wcl
	 OHjG+Q1NKQjCGtiaQhGHC4Jg1HH92iCvNcziDvwR0pkNLymb3YPchz3xOihBSxq4/kj0/
	 JpZLUXrMqJn4M9EwafHwjM1HU1PUIpJkiCU6o/SlkUxurer/r8ANRVNl7/P959YqfSmID
	 nc+NVm/mQ1N4bBkXOP7twzwkXwxebZVWQ28eiA0Z1/hwXQ8/pW6dQv7hztuW3Y46bK2js
	 4tDAFWuGt3SaRJSN9jG5JqgMd0j9zuPrbvMgQBHEjJQyCgACcDrt12QZB/h/T8EuwDg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795212500;
	bh=aesx/pFBQichM7IPvpkka+4T8BAiu15aejMTw1ZBSSg=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=q0rDBL2mMdUx5E8vDOk4t6xR2Eo6//HiWFmVIGnbZZkmHSPxvKqDT8n4/NsqLS3up
	 mJl2MeUQPF3y7Bwhkr4lKrGt6B9/m4UianX42sqfEBdN//1khhAhaGRUkFGJKrhfH1
	 ibXEXHoCXLouMFOYstZD+ZuIn4ceZD72RRlz8m+rbPRDeDc7QAlUtw8Qg3yNQNyq6x
	 uf1/beRceYblXKpKiF1rnHj6xtmZejxLltpOSGGnDUP8AixqbjPiqcV77XFbbZCDpM
	 30v4KNMOtA4Naql9OlXnXd+YgdjSv8DQQia+52UeIDAQ/u6RM2yAfS0LSPEftEIiKO
	 4B0XHwqsT1mNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF749811F7;
	Fri, 20 Nov 2026 22:08:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A1C9169
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F377340AB0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:34:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ikpZlUzORlP9 for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 19:34:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B4E9540208
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=doncuppjr@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=zKG8kJ7z
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B4E9540208
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 19:34:54 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b88b74e54eso1533520a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 11:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795203292; x=1795808092;
 darn=lists.u-boot-project.org; 
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aesx/pFBQichM7IPvpkka+4T8BAiu15aejMTw1ZBSSg=;
 b=zKG8kJ7zIlRfV1QkFZLlS5+9E5BIxaGONrSKEx8BQjJbhxs8DtCHef+u4w1WGUKt2E
 xtqRdY53TFZVQAGKz6r67Rz6SOVIYvmztiylg++oAhTJN0fiWr136f798nNFRnTxz8C/
 6AGMGSirnKCmg/otN3Z90HvaXssMhg1nmVzBC6nYNhnSgcNznkZFqKHOLy44cFAarouD
 AlEcPdTueWoD9doLed28F5H5p+kUZwkJbwTdb7wNEbtdKd4SOowNWD90SUuPtVF6YtNU
 MCzcZnRcXotdE9dSmhXiJ82wrLPIQUC8q0rs7q0aujDOiS+Kat+RtNEy5zImEq8MqhxP
 QqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795203292; x=1795808092;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aesx/pFBQichM7IPvpkka+4T8BAiu15aejMTw1ZBSSg=;
 b=V6+uEWDPytmXhQDqeNKZShOkmEe6fhggYvekzJSWnHj6lHaSnGgCUPanL7NVwz0jXa
 0erus+8F0nwdLrOv1n3ftVm10p4xrf56ntWhd85fEsXc/oESwy9VTHvXD3/QOIG2lq2d
 tEZFhI0YUUXthGhfjpSL0YNNbKb3aFIcwzihUarVXKEWyuJFeKsMYMzf/kSNvloMCORJ
 y5O+arM/Y38iJSmU/yzUKvnl5H4fAeakmoV3QYfIav5m1UuRgH13NNlWT0no/+L2s6YW
 jXRiTkNg/ikPdn0r1U/436TYZoe2nGhJXmySY3+pUj6q14JQeCZ2kNfPM1vhlf0e/3Oo
 UWEA==
X-Gm-Message-State: APuU4Z8zyPFpUDh9H0HqvxB/xGmH3C9PHK+S45kn+3B/lc2ruUoDzT/b
 1kefJduew8kFpibG6Msuq+qX5FySWyQF7IRh6Ui4PLazvmcq71/0vkqywBYu6k0/SGhY7dllO0v
 KCiHqtfad1cKSIpO3hvxR5nJs7TUec1G3gQ==
X-Gm-Gg: AZFdTZf7+w3BCrXIc9KeM1z6M0nGGH25rWfghGqawitGGXIbaaLzBrUmNAS8Cxb1opa
 I1Mjsv4+Q1t5y6NebmpPmcEkurlF4DnP9t7+xaaI+xjX+01+DcEGaW8cpYMwTyAsOzBLD83SDsh
 9hNlRfGT07Ep2hrwa91xE5yVw4KZWC8p+7Rbey9IZUHywTveURaRLgyMIo8SH38aUk0EE+3RvqJ
 h/Ujp3nSO4B++QwG0DVJMeARkiCerqDNXsftxJaxdCdY3Jb+3+phtF6+2dcPh+Im8uJNrZcVXoX
 BGK2092D/oCEoxbTXGUXtUXHvc4YexBlngeFr49/Di824YnGweD4KAd/B4PilcnrFKhSXpjKtZn
 h5AO+MXBEYFMOen7SlEdkxO//2ltUKeBkjIs=
X-Received: by 2002:a05:6402:1e8a:b0:6ba:1f45:3242 with SMTP id
 4fb4d7f45d1cf-6ba37e75750mr3267223a12.20.1795203292191; Fri, 20 Nov 2026
 11:34:52 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Fri, 20 Nov 2026 11:34:50 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Donald Cupp <doncuppjr@gmail.com>
Date: Fri, 20 Nov 2026 11:34:50 -0800
X-Gm-Features: Aa3M54p8ZPl0GCz407BFGRDlUtu_n7-jN0BK76ua7nJIH-wi2lqr8POYglhizEE
Message-ID: <CAO+UxrWgDc-RxKzOf+pxpG64ZwTJ9XaXv-ujjGq6XghiEcwNqg@mail.gmail.com>
Subject: [BUG] BCM2712: PCIe MMIO write makes ASM1182e switch inaccessible
To: u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="00000000000087e1d70660ba563d"
X-Mailman-Approved-At: Fri, 20 Nov 2026 22:08:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000087e1d70660ba563d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi U-Boot developers,

I=E2=80=99m investigating an NVMe initialization failure on a Raspberry Pi =
5 with a
Geekworm X1004 PCIe switch HAT.

Hardware

   - Raspberry Pi 5 / BCM2712
   - ASMedia ASM1182e PCIe switch (1b21:1182)
   - Samsung 980 NVMe (144d:a809)
   - Upstream U-Boot v2026.10, with NVMe support enabled

Both Fedora Linux 7.3.4 and Raspberry Pi Linux 6.18 operate the SSD
successfully.

Minimal reproduction

U-Boot enumerates the complete PCIe topology and reads the SSD=E2=80=99s NV=
Me CAP
register correctly. However, a single zero-value MMIO write to the NVMe
INTMS register causes the entire switch to become inaccessible.

With the SSD BAR mapped to CPU address 0x1b00100000:

pci enum
pci display.l 1.0.0 0 1
md.l 1b00100000 2
mw.l 1b0010000c 0 1
pci display.l 1.0.0 0 1

The switch=E2=80=99s upstream PCI vendor/device read changes from 0x11821b2=
1 to
0xffffffff.

The Broadcom root port remains accessible and reports an active PHY/Data
Link. The failure also occurs without NVMe queue initialization or DMA.

Additional findings

   - Root AER status and PCIe receive-error counters remain unchanged.
   - Linux-equivalent bridge memory windows and BAR placement do not
   resolve the failure.
   - Gen1 link speed, CLKREQ safe mode, and Linux-equivalent PCIe control
   settings do not resolve it.
   - Repeating PCI configuration reads works around a separate stale-read
   issue but does not restore access after the MMIO write.
   - Changing UBUS error-reporting behavior exposes an ARM SError rather
   than fixing the transaction.

I have serial captures, source instrumentation, and additional diagnostic
results available.

I=E2=80=99d appreciate guidance on the BCM2712 outbound Memory Write path o=
r other
controller status registers that could explain why a posted Memory Write
leaves all devices behind the switch inaccessible while the root port still
reports an active link.

Thank you.

--00000000000087e1d70660ba563d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>Hi U-Boot developers,</p>
<p>I=E2=80=99m investigating an NVMe initialization failure on a Raspberry =
Pi 5 with a Geekworm X1004 PCIe switch HAT.</p>
<p>Hardware</p>
<ul>
<li>Raspberry Pi 5 / BCM2712</li>
<li>ASMedia ASM1182e PCIe switch (1b21:1182)</li>
<li>Samsung 980 NVMe (144d:a809)</li>
<li>Upstream U-Boot v2026.10, with NVMe support enabled</li>
</ul>
<p>Both Fedora Linux 7.3.4 and Raspberry Pi Linux 6.18 operate the SSD succ=
essfully.</p>
<p>Minimal reproduction</p>
<p>U-Boot enumerates the complete PCIe topology and reads the SSD=E2=80=99s=
 NVMe CAP register correctly. However, a single zero-value MMIO write to th=
e NVMe INTMS register causes the entire switch to become inaccessible.</p>
<p>With the SSD BAR mapped to CPU address 0x1b00100000:</p>
<p>pci enum<br>
pci display.l 1.0.0 0 1<br>
md.l 1b00100000 2<br>
mw.l 1b0010000c 0 1<br>
pci display.l 1.0.0 0 1</p>
<p>The switch=E2=80=99s upstream PCI vendor/device read changes from 0x1182=
1b21 to 0xffffffff.</p>
<p>The Broadcom root port remains accessible and reports an active PHY/Data=
 Link. The failure also occurs without NVMe queue initialization or DMA.</p=
>
<p>Additional findings</p>
<ul>
<li>Root AER status and PCIe receive-error counters remain unchanged.</li>
<li>Linux-equivalent bridge memory windows and BAR placement do not resolve=
 the failure.</li>
<li>Gen1 link speed, CLKREQ safe mode, and Linux-equivalent PCIe control se=
ttings do not resolve it.</li>
<li>Repeating PCI configuration reads works around a separate stale-read is=
sue but does not restore access after the MMIO write.</li>
<li>Changing UBUS error-reporting behavior exposes an ARM SError rather tha=
n fixing the transaction.</li>
</ul>
<p>I have serial captures, source instrumentation, and additional diagnosti=
c results available.</p>
<p>I=E2=80=99d appreciate guidance on the BCM2712 outbound Memory Write pat=
h or other controller status registers that could explain why a posted Memo=
ry Write leaves all devices behind the switch inaccessible while the root p=
ort still reports an active link.</p>
<p>Thank you.</p>

--00000000000087e1d70660ba563d--
