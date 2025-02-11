Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C44C021A1
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 14:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA1F380BA9;
	Tue, 11 Feb 2025 15:56:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="GP/YBsEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19CE5807E1; Tue, 11 Feb 2025 14:58:48 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B576E80077
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 14:58:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fiona.klute@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739282324; x=1739887124; i=fiona.klute@gmx.de;
 bh=8yMVYhr9P4Nr/fmb/BRDwOCQ1bHs8+fNLT6H0P3E06c=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=GP/YBsEQ8IxcRoU/V3UYwpdOzO/yNeH1Tksf9rMtFc4exhQsPjpP11XVe5fG81Un
 Ncub+qJJvVQQFZLNcJatHLWZ9+dMzIku7ulEBJ+HONKQP/jdCntpEf1LMXy0fn1l7
 qlhNrEj/SlDENqfr81fCntxUPTR/l7ECAz1mUC6JXbRCvAMD3rLzjVMKkjdzyomhz
 4zE58ThgE6p9t7Ef53F9PDkTLoApiAXOBM3nJKvAJaIhY9SCQtP2CE5dJPFdcaV5B
 DB+Fedr1FCMnmqRk7y1gL9U4YDReiNqoZ8hAq+42FDsYRlDWbNccGXF9Hxi0PuRXy
 P4IwBHWNAhJxVBE4bg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.118.163]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hvR-1tHp3c3wbX-017plf; Tue, 11
 Feb 2025 14:58:44 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: u-boot@lists.denx.de
Cc: Fiona Klute <fiona.klute@gmx.de>, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [RFC] Raspberry Pi: copy /system/linux, {serial,
 revision} from firmware
Date: Tue, 11 Feb 2025 14:58:29 +0100
Message-ID: <20250211135829.3467088-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:gLTn3gr9DsC4UxuGduzFLAdjpXHODXyLdVipVa946O+9JW/goKo
 VEUA69yH/JtI2MJMq61l9zhMFo94KQP75thxMIQiGZ5cxvC3D2P5IvfFntXw6/gHs1uoGd7
 ZCoY5UrkYAdDDtW8mGNAbj2EzjxJawCcfQtEJQqha8jfWy9Zyxdp6wyuuPMmTnUrF9udzGS
 7a7Y0OgoTli4OnfjAJQxg==
UI-OutboundReport: notjunk:1;M01:P0:llzI7rlf+zM=;6fsG8DsRa8Rv3fw4Fvoxi+HqT7q
 sV+U+tfFboDAwDvxYr8lNmvkKkxEYV8Kgg3HHBRKNQN+4xi/dySSP/GCzz5eK8c1SpUa7GvcM
 RdtnwxDVBStnaU2pQ1dujEh4zYL1Fp9iRmUceutPyC6LbMZoIHYzkGuQXgVxCJuNNIGTHkfNa
 LynbvBHuz7gHXp7LQ5tKdGTSK6xKWS5MN72iiMZ8/F+XppgS+7eba5iqrowDP7CWQKDIl8kxn
 Ii+kq4cJxahplGd558j1aqX2uHmfYi5ABlrUcHYAPT7WNWaZx/G6KHaImXzoNCX3tXMC7k05g
 gLC2JzcJh5/1BHnR1jW5Nya7Y6RuL3NNUgH91yX5yU+1aT0bA67ugLe0CiEawgSj/fubRJ5xg
 7R3Bdwbn4Dxm3qFo48O7uiWqA0vAhWaRgK6pejszM+S0lTjuSPZ4Y7JKuAT3RlDRryYlSvCH8
 VU93hVIEiD2mN1V7RmGyRQa6MZQreoQX3bA0NGF8v84A1kX2s3pErQo88rQI8Fc3NANEjdr74
 9WsqdklmR9IRBe0lMpNltttDtfTwJeUvt9LLoCHZolNzL0S+5FXPlNtownfhi7kWImjdufZw1
 97wH0V8yr9L40RV10MdQhoiDtrEJf0vgsOx6r3IqnTGJT4AlV/jrWvjgq/ppiFbCmoJC9tU1F
 hkztqHemIh425AIifBABuNQ+0iEVMHNvNc8zs0LnWicp/5tIllLW199gECtlWA2nlWd+m+Rln
 r1/A50K6cEpfzhXHWZmzI4AaoppwWcG7f8AfiDirmIeUBvQmL9CBWVARj1IdPc4Ue4zlukoAg
 DFLw3yHV4rtucG0+GnooW21sBhBAvI3xWDI1YDY1JXQo47d3/JbpYgRbr2swWAWZ0kA839kZO
 NA4mAFIBya2jHa+9t65kdsiW9ZtoTeQsU9ULQtAq/NQefmIyJe0k1d64iuxQReBlgYlTHpYss
 4l1iVwxsG5yxjoi85ZFAPltny4vrTvuO7HqKBJ6aHyefAmA8l9TEHjApH+whGE6aO9NoeBUFE
 Xms3mH7Ru99Q8jQthic4vgCfcUgOpI+sWcs4PoBa1Jj++pp38b0bciQeCrOk7zvHTEJ1sRiYB
 02Uurhb4ZgJ9X2hws8Fx07PrKN4LYWdudYtQiwVGt2pmTk2lwfkROUClE4McLs0Hp/zySjZC5
 8I5TkAjWVEYcLIuRB5ro6TKxZdY0v5dvowJGdqQuY7JI6En5cSjYg629p3gJBPajV8RxE1k1u
 PMEMidPGeFHJI4j7R2cJr4oI6pIncOQvk2Xk2PdVl5Jwg+N/3AIIUwexOR1M45Qickrcfq8BS
 wlR9CO0dT9NX+Hd7DMKEqPiE1Yxys9U+ZTln69ATr22FxeO6PclGNZGroqd2kEMvfIBXa7NUA
 2djqschKAJqD4fms9Wq9ninYMUsXj0YxQMRRTYQML0JTiBkLKgmTWoKGYRrzU1bp9scDGs/17
 quaYxIp9eS97PnYZtC3jqg7A2PEGsB2s/qP3clPJ4aKI9qqV5
X-Mailman-Approved-At: Tue, 11 Feb 2025 15:56:27 +0100
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

Qm90aCB0aGUgUmFzcGJlcnJ5IFBpIGRvd25zdHJlYW0ga2VybmVsIFsxXSBhbmQgc29tZSB1c2Vy
c3BhY2UgdG9vbHMKWzJdIHVzZSB0aGUgcmV2aXNpb24gcHJvcGVydHkgdG8gaWRlbnRpZnkgdGhl
IGJvYXJkLCBhbmQgdGhlIGxhdHRlcgpmYWlscyBpZiBpdCBpcyBhYnNlbnQuIFRoZSBmaXJtd2Fy
ZSBjcmVhdGVzIHRoZSAvc3lzdGVtIG5vZGUsIHNvIHdlCm5lZWQgdG8gZG8gdGhlIHNhbWUuCgpb
MV0gaHR0cHM6Ly9naXRodWIuY29tL3Jhc3BiZXJyeXBpL2xpbnV4L2Jsb2IvMGYyOTJmYmI2MzQ2
YjA1NzY2MTUyOTAyMDc2ODk1NTU4YWMyM2Y5YS9hcmNoL2FybS9tYWNoLWJjbS9ib2FyZF9iY20y
ODM1LmMjTDIzLUwzMwpbMl0gaHR0cHM6Ly9naXRodWIuY29tL2pnYXJmZi9ycGlfd3MyODF4L2Js
b2IvN2ZjMGJmOGIzMWQ3MTViYmVjZjI4ZTg1MmVkZTVhYWEzODgxODBkYS9ycGlody5jI0w1NzkK
ClNpZ25lZC1vZmYtYnk6IEZpb25hIEtsdXRlIDxmaW9uYS5rbHV0ZUBnbXguZGU+CkNjOiBNYXR0
aGlhcyBCcnVnZ2VyIDxtYnJ1Z2dlckBzdXNlLmNvbT4KQ2M6IFBldGVyIFJvYmluc29uIDxwYnJv
Ymluc29uQGdtYWlsLmNvbT4KQ2M6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+Ci0tLQpJ
J20gc2VuZGluZyB0aGlzIGFzIFJGQyBiZWNhdXNlIEknbSBub3Qgc3VyZSBpZiBjcmVhdGluZyBh
IHRlbXBvcmFyeQpvdmVybGF5IGlzIHRoZSBiZXN0IGFwcHJvYWNoIGhlcmUsIGFkdmljZSBvbiBh
IGJldHRlciB3YXkgdG8gY3JlYXRlIHRoZQovc3lzdGVtIG5vZGUgaWYgbmVlZGVkIGlzIHZlcnkg
bXVjaCB3ZWxjb21lLiBJIGtub3cgSSdsbCBuZWVkIHRvIGFkZAptb3JlIGVycm9yIGNoZWNrcywg
SSdsbCBkbyB0aGF0IGFmdGVyIEkga25vdyBJIGhhdmUgdGhlIHJpZ2h0IGFwcHJvYWNoLgoKIGJv
YXJkL3Jhc3BiZXJyeXBpL3JwaS9ycGkuYyB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvYm9hcmQvcmFzcGJlcnJ5cGkvcnBpL3JwaS5jIGIvYm9hcmQvcmFzcGJlcnJ5cGkvcnBpL3Jw
aS5jCmluZGV4IGFhMzlhZmEzMzhhLi42NDc3MTYxMjdjNyAxMDA2NDQKLS0tIGEvYm9hcmQvcmFz
cGJlcnJ5cGkvcnBpL3JwaS5jCisrKyBiL2JvYXJkL3Jhc3BiZXJyeXBpL3JwaS9ycGkuYwpAQCAt
NTUwLDYgKzU1MCw0MSBAQCBpbnQgY29weV9wcm9wZXJ0eSh2b2lkICpkc3QsIHZvaWQgKnNyYywg
Y2hhciAqcGF0aCwgY2hhciAqcHJvcGVydHkpCiAJcmV0dXJuIGZkdF9zZXRwcm9wKGRzdCwgZHN0
X29mZnNldCwgcHJvcGVydHksIHByb3AsIGxlbik7CiB9CiAKK2ludCBjb3B5X3N5c3RlbV9ub2Rl
KHZvaWQgKmZkdCwgdm9pZCAqZndfZmR0KQoreworCWNvbnN0IGZkdDMyX3QgKnByb3A7CisJY2hh
ciBmZHRvWzIwNDhdOworCWludCBzcmNfb2Zmc2V0OworCWludCBsZW47CisKKwlzcmNfb2Zmc2V0
ID0gZmR0X3BhdGhfb2Zmc2V0KGZ3X2ZkdCwgIi9zeXN0ZW0iKTsKKwlpZiAoc3JjX29mZnNldCA8
IDApCisJCXJldHVybiAtMTsKKworCWZkdF9jcmVhdGUoZmR0bywgc2l6ZW9mKGZkdG8pKTsKKwlm
ZHRfZmluaXNoX3Jlc2VydmVtYXAoZmR0byk7CisJZmR0X2JlZ2luX25vZGUoZmR0bywgIiIpOwor
CWZkdF9iZWdpbl9ub2RlKGZkdG8sICJmcmFnbWVudCIpOworCWZkdF9wcm9wZXJ0eV9zdHJpbmco
ZmR0bywgInRhcmdldC1wYXRoIiwgIi8iKTsKKwlmZHRfYmVnaW5fbm9kZShmZHRvLCAiX19vdmVy
bGF5X18iKTsKKwlmZHRfYmVnaW5fbm9kZShmZHRvLCAic3lzdGVtIik7CisKKwlwcm9wID0gZmR0
X2dldHByb3AoZndfZmR0LCBzcmNfb2Zmc2V0LCAibGludXgsc2VyaWFsIiwgJmxlbik7CisJaWYg
KHByb3ApCisJCWZkdF9wcm9wZXJ0eShmZHRvLCAibGludXgsc2VyaWFsIiwgcHJvcCwgbGVuKTsK
Kwlwcm9wID0gZmR0X2dldHByb3AoZndfZmR0LCBzcmNfb2Zmc2V0LCAibGludXgscmV2aXNpb24i
LCAmbGVuKTsKKwlpZiAocHJvcCkKKwkJZmR0X3Byb3BlcnR5KGZkdG8sICJsaW51eCxyZXZpc2lv
biIsIHByb3AsIGxlbik7CisKKwlmZHRfZW5kX25vZGUoZmR0byk7CisJZmR0X2VuZF9ub2RlKGZk
dG8pOworCWZkdF9lbmRfbm9kZShmZHRvKTsKKwlmZHRfZW5kX25vZGUoZmR0byk7CisJZmR0X2Zp
bmlzaChmZHRvKTsKKworCWZkdF9vdmVybGF5X2FwcGx5X3ZlcmJvc2UoZmR0LCBmZHRvKTsKK30K
KwogLyogQ29weSB0d2Vha3MgZnJvbSB0aGUgZmlybXdhcmUgZHRiIHRvIHRoZSBsb2FkZWQgZHRi
ICovCiB2b2lkICB1cGRhdGVfZmR0X2Zyb21fZncodm9pZCAqZmR0LCB2b2lkICpmd19mZHQpCiB7
CkBAIC01NjAsNiArNTk1LDggQEAgdm9pZCAgdXBkYXRlX2ZkdF9mcm9tX2Z3KHZvaWQgKmZkdCwg
dm9pZCAqZndfZmR0KQogCS8qIFRoZSBmaXJtd2FyZSBwcm92aWRlcyBhIG1vcmUgcHJlY2lzZSBt
b2RlbDsgc28gY29weSB0aGF0ICovCiAJY29weV9wcm9wZXJ0eShmZHQsIGZ3X2ZkdCwgIi8iLCAi
bW9kZWwiKTsKIAorCWNvcHlfc3lzdGVtX25vZGUoZmR0LCBmd19mZHQpOworCiAJLyogbWVtb3J5
IHJlc2VydmUgYXMgc3VnZ2VzdGVkIGJ5IHRoZSBmaXJtd2FyZSAqLwogCWNvcHlfcHJvcGVydHko
ZmR0LCBmd19mZHQsICIvIiwgIm1lbXJlc2VydmUiKTsKIAotLSAKMi40Ny4yCgo=
